import pandas as pd
import requests
import csv
from io import StringIO
import json
import os
from tqdm import tqdm


def model(dbt, session):
    # Correctly access the variable from dbt_project.yml for the data dictionary URL
    data_dictionary_url = dbt.config.get(
        "public_use_microdata_sample_data_dictionary_url"
    )  # Assume this now points to the data dictionary CSV

    # Download and convert the CSV data dictionary to JSON
    response = requests.get(data_dictionary_url)
    response.raise_for_status()  # Ensure the request was successful

    reader = csv.reader(StringIO(response.text))
    data_dictionary = {}

    for row in reader:
        if row[0] == "NAME":
            data_dictionary[row[1]] = {
                "Type": row[2],
                "Length": row[3],
                "Description": row[4],
                "Values": {},
            }
        elif row[0] == "VAL" and row[1] in data_dictionary:
            data_dictionary[row[1]]["Values"][row[4]] = row[6] if len(row) > 6 else ""

    # Specify the path where the JSON file will be saved
    base_path = os.path.expanduser(
        dbt.config.get("output_path")
    )  # Correct method to access the variable
    # extract base name of the file from the URL
    file_name = os.path.basename(data_dictionary_url)
    # remove the file extension
    file_name = os.path.splitext(file_name)[0]
    json_file_path = os.path.join(base_path, f"{file_name}.json")

    # Save the data dictionary to a JSON file
    with open(json_file_path, "w") as json_file:
        json.dump(data_dictionary, json_file, indent=4)

    # Since the task is about returning a DataFrame with the path to the data dictionary,
    # we'll wrap up by creating such a DataFrame
    dictionary_path_df = pd.DataFrame(
        [json_file_path], columns=["data_dictionary_path"]
    )

    return dictionary_path_df
