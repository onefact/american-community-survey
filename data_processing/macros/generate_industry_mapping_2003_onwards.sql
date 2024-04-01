{% macro generate_industry_mapping_2003_onwards_sql(input_field) %}
{% set industry_mappings = get_industry_mappings_2003_onwards() %}

CASE {{ input_field }}
    {% for code, description in industry_mappings.items() %}
    WHEN '{{ code }}' THEN '{{ description }}'
    {% endfor %}
END::ENUM ({% for description in industry_mappings.values() | unique %}'{{ description }}'{{ "," if not loop.last }}{% endfor %})
{% endmacro %}
