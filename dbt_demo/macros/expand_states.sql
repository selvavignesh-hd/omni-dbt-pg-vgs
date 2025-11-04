{% macro expand_states(state_name) %}
    case when {{state_name}} ilike 'TN' then 'Tamil Nadu'
    when {{state_name}} ilike 'KA' then 'Karnataka'
    when {{state_name}} ilike 'KL' then 'Kerala'
    when {{state_name}} ilike 'AP' then 'Andhra Pradesh'
    when {{state_name}} ilike 'TS' then 'Telangana'
    when {{state_name}} ilike 'MH' then 'Maharashtra'
    when {{state_name}} ilike 'GA' then 'Gujarat'
    when {{state_name}} ilike 'MP' then 'Madhya Pradesh'
    when {{state_name}} ilike 'RJ' then 'Rajasthan'
    when {{state_name}} ilike 'UP' then 'Uttar Pradesh'
    when {{state_name}} ilike 'PN' then 'Punjab'
    when {{state_name}} ilike 'SP' then 'Sikkim'
    else {{state_name}}
    end
{% endmacro %}