{% macro convertString(column) %}
    lower({{ column }})
{% endmacro %}