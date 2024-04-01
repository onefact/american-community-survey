{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}
SELECT * FROM {{ ref('parse_data_dictionary') }}