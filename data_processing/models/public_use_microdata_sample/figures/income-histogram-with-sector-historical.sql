{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

WITH raw_data AS (
    SELECT
        CAST("WAGP" AS FLOAT) AS wage,
        CAST("ADJINC" AS FLOAT) AS adjustment_factor,
        "INDP" AS industry_code,
        "PUMA" AS puma,
        CAST("ADJUST" AS FLOAT) AS pre_2007_adjustment_factor,
        CAST(SUBSTRING(SPLIT_PART(filename, '/', 6), 1, 4) AS INT) AS year,
        ST AS state_code,
        "RAC1P" AS race,
        filename
    FROM read_csv_auto('~/data/american_community_survey/*/**/*pus*.csv', filename=true, union_by_name=true)
    WHERE
        "WAGP" IS NOT NULL AND 
        -- "ADJINC" IS NOT NULL AND 
        "INDP" IS NOT NULL
)
SELECT
    wage,
    adjustment_factor,
    pre_2007_adjustment_factor,
    industry_code,
    puma,
    year, 
    state_code,
    race
FROM raw_data
ORDER BY year, state_code, puma, industry_code, wage, adjustment_factor, pre_2007_adjustment_factor, race