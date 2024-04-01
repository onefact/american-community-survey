{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}
SELECT * FROM {{ ref('download_and_extract_shapefiles') }}
