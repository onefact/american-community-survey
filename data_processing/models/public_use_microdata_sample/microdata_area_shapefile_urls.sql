{{ config(
    materialized = 'external',
    location = var('output_path') + '/' + this.name + '.parquet'
) }}
SELECT *
FROM {{ ref('list_shapefile_urls') }}