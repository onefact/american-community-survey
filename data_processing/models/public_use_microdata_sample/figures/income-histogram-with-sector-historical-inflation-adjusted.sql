{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

WITH cpi_adjustment AS (
    SELECT
        year,
        consumer_price_index
    FROM {{ ref('consumer_price_index') }}
    WHERE year <= 2022  -- Assuming the table includes CPI data up to 2022
),
latest_cpi AS (
    SELECT
        consumer_price_index AS cpi_2022
    FROM cpi_adjustment
    WHERE year = 2022
),
adjusted_income AS (
    SELECT
        hi.year,
        hi.industry_code,
        (hi.wage * 
            CASE 
                WHEN hi.year >= 2007 THEN hi.adjustment_factor / 1000000 
                ELSE hi.pre_2007_adjustment_factor / 1000000 
            END
        ) * (lc.cpi_2022 / ca.consumer_price_index) AS adjusted_income_to_2022  -- Adjusting to 2022 dollars
    FROM {{ ref('income-histogram-with-sector-historical') }} hi
    JOIN cpi_adjustment ca ON hi.year = ca.year
    CROSS JOIN latest_cpi lc
    WHERE
        hi.wage IS NOT NULL AND 
        (
            hi.adjustment_factor IS NOT NULL OR 
            hi.pre_2007_adjustment_factor IS NOT NULL
        ) AND
        hi.industry_code IS NOT NULL
),
income_histogram AS (
    SELECT
        year,
        adjusted_income_to_2022 AS income,
        industry_code,
        COUNT(*) AS count
    FROM adjusted_income
    GROUP BY year, adjusted_income_to_2022, industry_code
)
SELECT * FROM income_histogram
ORDER BY year, income, industry_code
