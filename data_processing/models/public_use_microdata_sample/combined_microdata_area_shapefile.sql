-- {{ config(materialized='external', location=var('output_path') + '/' + this.name + '.shp') }}
COPY (
WITH combined_shp AS (
    {{ generate_shp_load_sql() }}
)
SELECT * FROM combined_shp
) TO '{{ var('output_path') + '/' + this.name + '.shp' }}' WITH (FORMAT GDAL, )