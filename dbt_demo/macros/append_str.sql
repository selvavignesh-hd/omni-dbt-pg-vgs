{% macro append_to_string(left_expr, suffix) %}
    concat({{ left_expr }}, {{ suffix }})
    {%- if execute -%}
        {{ log('Appending ' ~ suffix ~ ' to ' ~ left_expr, info=True) }}
    {%- endif -%}
{% endmacro %}