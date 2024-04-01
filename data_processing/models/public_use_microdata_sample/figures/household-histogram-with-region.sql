{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

WITH rent_data AS (
    SELECT
        CAST("Gross rent (monthly amount, use ADJHSG to adjust GRNTP to constant dollars)" AS INT) AS rent,
        "Division code based on 2010 Census definitions Division code based on 2020 Census definitions" AS region
    FROM '~/data/american_community_survey/upload/2022_acs_pums_housing_units_united_states*.parquet'
    WHERE
        "Gross rent (monthly amount, use ADJHSG to adjust GRNTP to constant dollars)" IS NOT NULL AND
        "Gross rent (monthly amount, use ADJHSG to adjust GRNTP to constant dollars)" <> 0 AND
        "Division code based on 2010 Census definitions Division code based on 2020 Census definitions" IS NOT NULL
),
histogram_data AS (
    SELECT
        rent,
        region,
        CAST(COUNT(*) AS INT32) AS count
    FROM rent_data
    GROUP BY rent, region
    HAVING COUNT(*) > 0
)
SELECT * FROM histogram_data
ORDER BY rent, region