import requests
import csv
from io import StringIO
import json
import sys


def csv_to_json_dictionary(url):
    response = requests.get(url)
    response.raise_for_status()  # Ensure the request was successful

    # Read the CSV content into a dictionary structure
    data_dictionary = {}
    reader = csv.reader(StringIO(response.text))

    for row in reader:
        if row[0] == "NAME":
            # Initialize the variable entry with its details
            data_dictionary[row[1]] = {
                "Type": row[2],
                "Length": row[3],
                "Description": row[4],
                "Values": {},
            }
        elif row[0] == "VAL" and row[1] in data_dictionary:
            # Append value mappings to the variable
            data_dictionary[row[1]]["Values"][row[4]] = row[6] if len(row) > 6 else ""

    # Return the constructed dictionary
    return data_dictionary


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <data_dictionary_url>")
        sys.exit(1)

    url = sys.argv[1]
    data_dict = csv_to_json_dictionary(url)

    # Specify the JSON file name
    json_file_name = "PUMS_Data_Dictionary.json"
    with open(json_file_name, "w") as json_file:
        json.dump(data_dict, json_file, indent=4)

    print(f"Data dictionary processed and saved to {json_file_name}.")
