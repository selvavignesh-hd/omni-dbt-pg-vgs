{{ config(
    materialized='table',
    schema='netflix_analytics'
) }}

select
    type,
    count(*) as total_count,
    count(distinct title) as unique_titles,
    min(release_year) as earliest_release_year,
    max(release_year) as latest_release_year,
    avg(case when type = 'Movie' then movie_duration_minutes end) as avg_movie_duration_minutes,
    avg(case when type = 'TV Show' then tv_show_seasons end) as avg_tv_show_seasons,
    count(case when date_added_parsed >= current_date - interval '1 year' then 1 end) as added_last_year,
    count(case when date_added_parsed >= current_date - interval '6 months' then 1 end) as added_last_6_months
from {{ ref('stg_netflix_titles') }}
group by type
order by total_count desc

