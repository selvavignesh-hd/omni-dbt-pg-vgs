{{ config(
    materialized='table',
    schema='semantic_layer'
) }}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2020-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    )}}
)

select 
    date_day as date_day,
    date_day as date_week,
    date_trunc('month', date_day) as date_month,
    date_trunc('quarter', date_day) as date_quarter,
    date_trunc('year', date_day) as date_year
from date_spine