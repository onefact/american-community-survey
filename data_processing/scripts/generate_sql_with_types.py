import pandas as pd
import duckdb
import sys
import os
import json


def generate_materialized_name(folder_name, csv_name, state_lookup, national_lookup):
    # Extract the state code and type (P or H) from the folder name
    type_char = folder_name.split("_")[1][
        0
    ].lower()  # Assuming folder format is "csv_PXX" or "csv_HXX"
    folder_code = folder_name.split("_")[1][1:].upper()

    # Determine the human-readable name based on the type character
    human_readable_name = "individual_people" if type_char == "p" else "housing_units"

    if folder_code == "US":
        # Get the national-level name from the lookup table
        csv_code = csv_name.split("_")[1][1:].upper()
        name = national_lookup.get(csv_code, "Unknown national code")
        print(csv_code, name)
    elif len(folder_code) == 2:
        # Get the state name from the lookup table
        name = state_lookup.get(folder_code, "Unknown state code")
        print(folder_code, name)
    else:
        raise ValueError(f"Invalid code: {folder_code}")
    # Return the formatted name
    return f"{human_readable_name}_{name.replace(' ', '_')}".lower()


if len(sys.argv) < 3:
    print("Usage: python script.py <parquet_database_path> <PUMS_data_dictionary_path>")
    sys.exit(1)

parquet_database_path, data_dictionary_path = sys.argv[1:3]

# Load the data dictionary from the JSON file
with open(data_dictionary_path, "r") as json_file:
    data_dict = json.load(json_file)

# Generate lookup table for state codes
state_lookup = {
    code: name
    for name, code in [x.split("/") for x in data_dict["ST"]["Values"].values()]
}

# define short codes for first and second tranches of national-level data
national_lookup = {
    "USA": "United States first tranche",
    "USB": "United States second tranche",
}

# Connect to DuckDB
conn = duckdb.connect(database=":memory:", read_only=False)

# Assuming the Parquet file contains paths to CSV files
df_csv_paths = pd.read_parquet(parquet_database_path)

models_dir = "models/public_use_microdata_sample/generated/with_types"
os.makedirs(models_dir, exist_ok=True)

for csv_path in df_csv_paths["csv_path"]:
    folder_name = os.path.basename(os.path.dirname(csv_path))
    csv_name = os.path.basename(csv_path)
    csv_name = csv_name.split(".")[0]
    materialized_name = generate_materialized_name(
        folder_name, csv_name, state_lookup, national_lookup
    )

    df_headers = pd.read_csv(csv_path, nrows=0)
    column_types = {column: 'VARCHAR' for column in df_headers.columns}
    columns = ', '.join([f"'{col}': '{typ}'" for col, typ in column_types.items()])

    sql_select_parts = ["SELECT"]
    for header in df_headers.columns:
        col_info = data_dict.get(header, {"Description": header})
        description = col_info["Description"]
        sql_select_parts.append(f'    {header} AS "{description}",')

    sql_select_parts[-1] = sql_select_parts[-1].rstrip(",")
    sql_select_statement = "\n".join(sql_select_parts)
    
    sql_content = f"""-- SQL transformation for {os.path.basename(csv_path)} generated by {os.path.basename(__file__)}
{{{{ config(materialized='external', location=var('output_path') + '/{materialized_name}.parquet') }}}}
{sql_select_statement}
FROM read_csv('{csv_path}', columns={{{columns}}})"""

    sql_file_path = os.path.join(models_dir, f"{materialized_name}.sql")
    with open(sql_file_path, "w") as sql_file:
        sql_file.write(sql_content)
