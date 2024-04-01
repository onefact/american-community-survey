{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

WITH historical_microdata_areas AS (
    SELECT DISTINCT source_state_code, target_state_code, source_puma, source_puma_name, year, target_puma, target_puma_name
    FROM {{ ref('historical_microdata_areas_intersection_with_core_based_statistical_area') }}
),
cpi_adjustment AS (
    SELECT
        year,
        consumer_price_index
    FROM {{ ref('consumer_price_index') }}
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
        hi.state_code AS source_state_code,
        hi.puma AS source_puma,
        hma.target_state_code,
        hma.target_puma,
        hma.target_puma_name,
        hi.year,
        hi.industry_code,
        hi.race,
        hi.wage * iaf.adjustment_factor_to_2022 AS adjusted_income_to_2022
    FROM {{ ref('income-histogram-with-sector-historical') }} hi
    JOIN inflation_adjustment_factors iaf ON hi.year = iaf.year
    LEFT JOIN historical_microdata_areas hma ON hi.state_code = hma.source_state_code AND hi.puma = hma.source_puma 
    WHERE
        hi.wage IS NOT NULL AND hma.source_puma IS NOT NULL
),
income_histogram AS (
    SELECT
        year,
        source_state_code,
        target_state_code,
        target_puma AS puma,
        target_puma_name AS puma_name,
        industry_code,
        race,
        adjusted_income_to_2022,
        SUM(count) AS count
    FROM (
        SELECT
            year,
            source_state_code,
            target_state_code,
            target_puma,
            target_puma_name,
            industry_code,
            race,
            adjusted_income_to_2022,
            COUNT(*) AS count
        FROM preliminary_adjusted_income
        GROUP BY year, source_state_code, target_state_code, source_puma, target_puma, target_puma_name, industry_code, race, adjusted_income_to_2022
    ) AS subquery
    GROUP BY year, source_state_code, target_state_code, target_puma, target_puma_name, industry_code, race, adjusted_income_to_2022
),
final_output AS (
    SELECT
        ih.year,
        ih.source_state_code,
        ih.target_state_code,
        ih.puma AS target_puma,
        ih.puma_name AS target_puma_name,
        ih.race,
        ih.adjusted_income_to_2022,
        ih.count,
        CASE
            WHEN ih.year < 2003 THEN
                {{ generate_industry_mapping_before_2003_sql('ih.industry_code') }}
            ELSE
                {{ generate_industry_mapping_2003_onwards_sql('ih.industry_code') }}
        END AS industry_mapped
    FROM income_histogram ih WHERE ih.industry_code IS NOT NULL AND ih.puma IS NOT NULL AND ih.puma_name IS NOT NULL
),
race_transformation AS (
    SELECT
        fo.year,
        fo.source_state_code,
        fo.target_state_code,
        fo.target_puma,
        fo.target_puma_name,
        fo.adjusted_income_to_2022,
        fo.count,
        fo.industry_mapped,
        CASE fo.race
            WHEN '1' THEN 'White'
            WHEN '2' THEN 'Black or African American'
            WHEN '3' THEN 'American Indian'
            WHEN '4' THEN 'Alaska Native'
            WHEN '5' THEN 'American Indian or Alaska Native'
            WHEN '6' THEN 'Asian'
            WHEN '7' THEN 'Native Hawaiian and Other Pacific Islander'
            WHEN '8' THEN 'Other'
            WHEN '9' THEN 'Two or More'
        END::ENUM ('White','Black or African American','American Indian','Alaska Native','American Indian or Alaska Native','Asian','Native Hawaiian and Other Pacific Islander','Other','Two or More') AS race_recoded
    FROM final_output fo
),
sector_transformation AS (
    SELECT
        rt.year,
        rt.target_state_code AS state_code,
        rt.target_puma AS puma,
        rt.target_puma_name AS puma_name,
        rt.race_recoded,
        rt.adjusted_income_to_2022,
        rt.count,
        rt.industry_mapped,
        CASE
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'agr' THEN 'Agriculture, Forestry, Fishing and Hunting'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'ext' THEN 'Mining, Quarrying, and Oil and Gas Extraction'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'utl' THEN 'Utilities'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'con' THEN 'Construction'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'whl' THEN 'Wholesale Trade'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'inf' THEN 'Information'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'fin' THEN 'Finance and Insurance'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'ret' THEN 'Retail Trade'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'prf' THEN 'Professional, Scientific, and Technical Services'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'srv' THEN 'Management of Companies and Enterprises'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'adm' THEN 'Administrative and Support and Waste Management and Remediation Services'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'edu' THEN 'Educational Services'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'med' THEN 'Health Care and Social Assistance'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'ent' THEN 'Arts, Entertainment, and Recreation'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'mfg' THEN 'Manufacturing'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'trn' THEN 'Transportation and Warehousing'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'sca' THEN 'Services'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'mil' THEN 'Public Administration'
            WHEN LOWER(SUBSTRING(rt.industry_mapped, 1, 3)) = 'une' THEN 'Unemployed or Never Worked'
        END AS sector
    FROM race_transformation rt
)
SELECT
    year,
    state_code,
    puma,
    puma_name,
    race_recoded AS race,
    -- sector,
    adjusted_income_to_2022 AS income,
    SUM(count) AS count
FROM sector_transformation
GROUP BY year, state_code, puma, puma_name, race, income
ORDER BY year