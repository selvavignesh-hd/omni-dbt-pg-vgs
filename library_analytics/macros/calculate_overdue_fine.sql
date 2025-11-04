{% macro calculate_overdue_fine(overdue_days, membership_tier) %}
    {% set base_fine_per_day = 0.50 %}
    {% set premium_discount = 0.5 %}
    
    case 
        when {{ overdue_days }} <= 0 then 0
        when {{ membership_tier }} = 'premium' then 
            round({{ overdue_days }} * {{ base_fine_per_day }} * {{ premium_discount }}, 2)
        else 
            round({{ overdue_days }} * {{ base_fine_per_day }}, 2)
    end
{% endmacro %}