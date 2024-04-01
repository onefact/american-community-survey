{% macro get_industry_mappings_before_2003() %}
{% set raw_mappings = get_industry_mappings_2003_onwards() %}

{% set processed_mappings = {} %}
{% set seen_prefixes = {} %}  {# Use a dictionary to simulate a set #}

{% for code, description in raw_mappings.items() %}
    {% set prefix = code[:3] %}
    {% if prefix not in seen_prefixes %}
        {% do processed_mappings.update({code[:3]: description}) %}
        {% do seen_prefixes.update({prefix: true}) %}  {# Simulate set.add() by adding a key to the dictionary #}
    {% endif %}
{% endfor %}

{{ return(processed_mappings) }}
{% endmacro %}
