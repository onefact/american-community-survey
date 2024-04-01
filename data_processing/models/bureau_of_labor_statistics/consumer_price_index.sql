{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}
SELECT 
    YEAR AS year,
    "AVG" AS consumer_price_index
FROM {{ ref('download_consumer_price_index') }}