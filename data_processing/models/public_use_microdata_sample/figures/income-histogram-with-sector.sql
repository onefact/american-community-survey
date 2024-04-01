{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

WITH industry_renamed AS (
    SELECT
        CAST("Wages or salary income past 12 months (use ADJINC to adjust WAGP to constant dollars)" AS INT) AS income,
        CAST(COUNT(*) AS INT) AS count,
        "Industry recode for 2018 and later based on 2017 IND codes" AS industry
    FROM '~/data/american_community_survey/upload/2022_acs_pums_individual_people_united_states*.parquet'
    WHERE
        "Wages or salary income past 12 months (use ADJINC to adjust WAGP to constant dollars)" IS NOT NULL AND
        "Wages or salary income past 12 months (use ADJINC to adjust WAGP to constant dollars)" <> 0 AND
        "Industry recode for 2018 and later based on 2017 IND codes" IS NOT NULL 
    GROUP BY "Wages or salary income past 12 months (use ADJINC to adjust WAGP to constant dollars)", "Industry recode for 2018 and later based on 2017 IND codes"
    HAVING COUNT(*) > 0
),
sector_mapping AS (
    SELECT
        income,
        count,
        CASE
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'agr' THEN 'Agriculture, Forestry, Fishing and Hunting'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'ext' THEN 'Mining, Quarrying, and Oil and Gas Extraction'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'utl' THEN 'Utilities'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'con' THEN 'Construction'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'whl' THEN 'Wholesale Trade'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'inf' THEN 'Information'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'fin' THEN 'Finance and Insurance'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'ret' THEN 'Retail Trade'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'prf' THEN 'Professional, Scientific, and Technical Services'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'srv' THEN 'Management of Companies and Enterprises'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'adm' THEN 'Administrative and Support and Waste Management and Remediation Services'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'edu' THEN 'Educational Services'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'med' THEN 'Health Care and Social Assistance'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'ent' THEN 'Arts, Entertainment, and Recreation'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'mfg' THEN 'Manufacturing'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'trn' THEN 'Transportation and Warehousing'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'sca' THEN 'Services'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'mil' THEN 'Public Administration'
            WHEN LOWER(SUBSTRING(industry, 1, 3)) = 'une' THEN 'Unemployed, With No Work Experience In The Last 5 Years Or Earlier Or Never Worked'
        END AS sector
    FROM industry_renamed
)
SELECT * FROM sector_mapping
ORDER BY income, sector
