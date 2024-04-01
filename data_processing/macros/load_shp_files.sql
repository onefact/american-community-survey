{% macro generate_shp_load_sql() %}
{% set shapefile_paths = run_query("SELECT shp_path FROM " ~ ref('microdata_area_shapefile_paths')) %}

{% if execute %}
    {% set paths = shapefile_paths.columns[0].values() %}
    {% for path in paths %}
        {{ "SELECT * FROM '" ~ path ~ "'" }} {% if not loop.last %} UNION ALL {% endif %}
    {% endfor %}
{% endif %}
{% endmacro %}
