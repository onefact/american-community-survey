{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

WITH cpi_adjustment AS (
    SELECT
        year,
        consumer_price_index
    FROM {{ ref('consumer_price_index') }}
    WHERE year <= 2022
),
latest_cpi AS (
    SELECT
        MAX(consumer_price_index) AS cpi_2022
    FROM cpi_adjustment
    WHERE year = 2022
),
inflation_adjustment_factors AS (
    SELECT
        ca.year,
        ca.consumer_price_index,
        (lc.cpi_2022 / ca.consumer_price_index) AS adjustment_factor_to_2022
    FROM cpi_adjustment ca
    CROSS JOIN latest_cpi lc
),
preliminary_adjusted_income AS (
    SELECT
        hi.year,
        hi.industry_code,
        hi.wage * iaf.adjustment_factor_to_2022 AS adjusted_income_to_2022
    FROM {{ ref('income-histogram-with-sector-historical') }} hi
    JOIN inflation_adjustment_factors iaf ON hi.year = iaf.year
    WHERE
        hi.wage IS NOT NULL
),
income_histogram AS (
    SELECT
        year,
        industry_code,
        adjusted_income_to_2022,
        COUNT(*) AS count
    FROM preliminary_adjusted_income
    GROUP BY year, adjusted_income_to_2022, industry_code
),
final_output AS (
    SELECT
        ih.year,
        ih.adjusted_income_to_2022,
        ih.count,
        CASE
            WHEN ih.year < 2003 THEN
                {{ generate_industry_mapping_before_2003_sql('ih.industry_code') }}
            ELSE
                {{ generate_industry_mapping_2003_onwards_sql('ih.industry_code') }}
        END AS industry_mapped
    FROM income_histogram ih
),
sector_transformation AS (
    SELECT
        fo.year,
        fo.adjusted_income_to_2022,
        fo.count,
        fo.industry_mapped,
        CASE
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'agr' THEN 'Agriculture, Forestry, Fishing and Hunting'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'ext' THEN 'Mining, Quarrying, and Oil and Gas Extraction'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'utl' THEN 'Utilities'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'con' THEN 'Construction'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'whl' THEN 'Wholesale Trade'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'inf' THEN 'Information'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'fin' THEN 'Finance and Insurance'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'ret' THEN 'Retail Trade'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'prf' THEN 'Professional, Scientific, and Technical Services'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'srv' THEN 'Management of Companies and Enterprises'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'adm' THEN 'Administrative and Support and Waste Management and Remediation Services'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'edu' THEN 'Educational Services'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'med' THEN 'Health Care and Social Assistance'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'ent' THEN 'Arts, Entertainment, and Recreation'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'mfg' THEN 'Manufacturing'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'trn' THEN 'Transportation and Warehousing'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'sca' THEN 'Services'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'mil' THEN 'Public Administration'
            WHEN LOWER(SUBSTRING(fo.industry_mapped, 1, 3)) = 'une' THEN 'Unemployed, With No Work Experience In The Last 5 Years Or Earlier Or Never Worked'
        END AS sector
    FROM final_output fo
)
SELECT
    year,
    sector,
    adjusted_income_to_2022 AS income,
    SUM(count) AS count
FROM sector_transformation
GROUP BY year, sector, income
ORDER BY year, income DESC, sector
