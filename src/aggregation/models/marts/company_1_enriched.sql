-- Enhanced model for CompanyID 1 with enriched column names from va_t_fields
-- This model takes the same data as companyid_1 but replaces F1..FN column names 
-- with actual field titles from va_t_fields table

-- First, let's get the field mappings at compile time
{% set field_mappings_query %}
    select FieldID, F_Title from {{ ref('va_t_fields') }}
{% endset %}

{% if execute %}
    {% set results = run_query(field_mappings_query) %}
    {% set field_title_map = {} %}
    {% for row in results %}
        {% set _ = field_title_map.update({row[0]: row[1]}) %}
    {% endfor %}
{% else %}
    {% set field_title_map = {} %}
{% endif %}

-- Get the actual columns from companyid_1 at compile time
{% set companyid_1_relation = ref('companyid_1') %}
{% if execute %}
    {% set companyid_1_columns = adapter.get_columns_in_relation(companyid_1_relation) %}
{% else %}
    {% set companyid_1_columns = [] %}
{% endif %}

select 
    {% for column in companyid_1_columns %}
        {% if column.name.startswith('F') and column.name[1:].replace('_', '').isdigit() %}
            {% set field_number = column.name[1:].replace('_', '') | int %}
            {% if field_title_map.get(field_number) %}
                {% set field_title = field_title_map[field_number] %}
                -- Always make aliases unique by appending original column name
                {{ column.name }} as "{{ field_title }} {{ column.name }}"
            {% else %}
                {{ column.name }}
            {% endif %}
        {% else %}
            {{ column.name }}
        {% endif %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('companyid_1') }}
