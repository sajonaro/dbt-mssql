{% macro select_columns_except(table_name, exclude=[]) %}
    {%- set relation = ref(table_name) if table_name is string else table_name -%}
    {%- set columns = adapter.get_columns_in_relation(relation) -%}
    {%- set selected = [] -%}

    {%- for col in columns -%}
        {%- if col.name not in exclude -%}
            {%- do selected.append(adapter.quote(col.name)) -%}
        {%- endif -%}
    {%- endfor -%}

    {{ selected | join(', ') }}
{% endmacro %}