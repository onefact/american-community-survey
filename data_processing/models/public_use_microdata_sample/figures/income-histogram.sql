{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

SELECT
    CAST("Wages or salary income past 12 months (use ADJINC to adjust WAGP to constant dollars)" AS INT) AS income,
    CAST(COUNT(*) AS INT32) AS count, -- Counting the number of records for each combination of Age, Income, and Sex
    "Industry recode for 2018 and later based on 2017 IND codes" AS industry
FROM '~/data/american_community_survey/upload/2022_acs_pums_individual_people_united_states*.parquet'
WHERE
    "Wages or salary income past 12 months (use ADJINC to adjust WAGP to constant dollars)" IS NOT NULL AND
    "Wages or salary income past 12 months (use ADJINC to adjust WAGP to constant dollars)" <> 0 AND
    "Industry recode for 2018 and later based on 2017 IND codes" IS NOT NULL 
GROUP BY income, industry
HAVING COUNT(*) > 0
ORDER BY income, industry