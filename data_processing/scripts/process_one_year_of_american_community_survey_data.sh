#!/bin/bash

# Function to print time taken for each step in minutes and seconds
print_time_taken() {
  local start=$1
  local end=$2
  local step=$3
  local duration=$((end-start))
  local minutes=$((duration / 60))
  local seconds=$((duration % 60))
  echo "Time taken for $step: ${minutes} minutes and ${seconds} seconds."
}

# Check if the user has provided a year
if [ -z "$1" ]
then
  echo "You must provide a four-character year as an argument."
  exit 1
fi

YEAR=$1

# Capture start time
start=$(date +%s)

echo "Starting process for the year: $YEAR"

start_step=$(date +%s)

echo "Step 1: Listing URLs of the $YEAR 1-Year ACS PUMS data"
dbt run --select "public_use_microdata_sample.list_urls" \
        --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
        --threads 8

echo "Step 1: Saving the database of the $YEAR 1-Year ACS PUMS data"
dbt run --select "public_use_microdata_sample.urls" \
        --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
        --threads 8

# echo "Step 1: Listing URLs of the $YEAR 1-Year ACS PUMS data"
# dbt run --select "public_use_microdata_sample.list_urls" \
#         --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
#         --threads 8

# echo "Step 1: Saving the database of the $YEAR 1-Year ACS PUMS data"
# dbt run --select "public_use_microdata_sample.urls" \
#         --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
#         --threads 8

echo "Checking URLs..."
duckdb -c "SELECT * FROM '~/data/american_community_survey/urls.parquet'"

end_step=$(date +%s)
print_time_taken $start_step $end_step "Step 1"

start_step=$(date +%s)

echo "Step 2: Downloading and extracting the archives for all of the 50 states' PUMS files"
dbt run --select "public_use_microdata_sample.download_and_extract_archives" \
        --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
        --threads 8

echo "Saving paths to the CSV files..."
dbt run --select "public_use_microdata_sample.csv_paths" \
        --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
        --threads 8

echo "Checking presence of CSV files..."
duckdb -c "SELECT * FROM '~/data/american_community_survey/csv_paths.parquet'"


end_step=$(date +%s)
print_time_taken $start_step $end_step "Step 2"

echo "Step 3: Parsing the data dictionary"

# dbt run --select "public_use_microdata_sample.parse_data_dictionary" \
#         --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
#         --threads 8

# dbt run --select "public_use_microdata_sample.data_dictionary_path" \
#         --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
#         --threads 8

# dbt run --select "public_use_microdata_sample.parse_data_dictionary" \
#         --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
#         --threads 8

# dbt run --select "public_use_microdata_sample.data_dictionary_path" \
#         --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
#         --threads 8

# echo "Checking data dictionary path..."
# duckdb -c "SELECT * FROM '~/data/american_community_survey/data_dictionary_path.parquet'"

# echo "Step 4: Generating SQL commands for mapping variables"
# python scripts/generate_sql_with_enum_types_and_mapped_values_renamed.py \
#        ~/data/american_community_survey/csv_paths.parquet \
#        ~/data/american_community_survey/PUMS_Data_Dictionary_$YEAR.json

# echo "Step 5: Executing generated SQL queries"
# dbt run --select "public_use_microdata_sample.generated.$YEAR.enum_types_mapped_renamed+" \
#         --vars '{"public_use_microdata_sample_url": "https://www2.census.gov/programs-surveys/acs/data/pums/'$YEAR'/1-Year/", "public_use_microdata_sample_data_dictionary_url": "https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_'$YEAR'.csv", "output_path": "~/data/american_community_survey"}' \
#         --threads 8

# echo "Step 6: Testing presence and size of compressed parquet files"
# du -sh ~/data/american_community_survey/$YEAR
# du -hc ~/data/american_community_survey/*$YEAR.parquet

# echo "Checking SQL query execution..."
# duckdb -c "SELECT COUNT(*) FROM '~/data/american_community_survey/*individual_people_united_states*$YEAR.parquet'"

# Capture end time
end_step=$(date +%s)

print_time_taken $start_step $end_step "Step 3"

# Calculate and report the total time taken
print_time_taken $start $end_step "Total 3"
