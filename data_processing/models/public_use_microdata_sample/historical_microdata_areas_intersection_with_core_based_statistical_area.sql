{{ config(materialized='external', location=var('output_path') + '/' + this.name + '.parquet') }}

WITH puma_2020 AS (
  SELECT STATEFP20 AS state_code, PUMACE20 AS puma_code, NAMELSAD20 AS puma_name, 2020 AS year, geom FROM '/Users/me/data/american_community_survey/shapefiles/TIGER2020/PUMA20/combined/TIGER2020_PUMA20.shp'
),
cbsa_new_york_2020 AS (
  SELECT * FROM '~/data/american_community_survey/shapefiles/tl_2020_us_cbsa.shp'
  WHERE NAMELSAD LIKE '%New York%'
),
puma_2020_new_york AS (
  SELECT puma.state_code AS source_state_code, puma.state_code AS target_state_code, puma.puma_code AS source_puma, puma.puma_name AS source_puma_name, puma.year, puma.geom
  FROM puma_2020 puma
  JOIN cbsa_new_york_2020 cbsa
  ON ST_Intersects(puma.geom, cbsa.geom)
),
puma_2010 AS (
  SELECT STATEFP10 AS state_code, PUMACE10 AS puma_code, NAMELSAD10 AS puma_name, 2010 AS year, geom FROM '/Users/me/data/american_community_survey/PUMA5/2010/combined/TIGER2010_PUMA10.shp'  
),
puma_2010_new_york AS (
  SELECT puma_2010.state_code AS source_state_code, puma_2020.target_state_code AS target_state_code, puma_2010.puma_code AS source_puma, puma_2010.puma_name AS source_puma_name, puma_2010.year, puma_2020.source_puma AS target_puma, puma_2020.source_puma_name AS target_puma_name, puma_2010.geom
  FROM puma_2010
  JOIN puma_2020_new_york puma_2020 
  ON ST_Intersects(puma_2010.geom, puma_2020.geom)
),
final_pumas AS (
  SELECT source_state_code, target_state_code, source_puma, source_puma_name, year, source_puma AS target_puma, source_puma_name AS target_puma_name, geom FROM puma_2020_new_york
  UNION ALL
  SELECT source_state_code, target_state_code, source_puma, source_puma_name, year, target_puma, target_puma_name, geom FROM puma_2010_new_york  
)
SELECT source_state_code, target_state_code, source_puma, source_puma_name, target_puma, target_puma_name, year, geom FROM final_pumas