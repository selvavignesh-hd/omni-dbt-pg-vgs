{{ config(
    materialized='table',
    schema='netflix_analytics'
) }}

select
    date_added_parsed as date_added,
    date_trunc('month', date_added_parsed) as month_added,
    date_trunc('year', date_added_parsed) as year_added,
    count(*) as total_added,
    count(case when type = 'Movie' then 1 end) as movies_added,
    count(case when type = 'TV Show' then 1 end) as tv_shows_added,
    count(distinct country) as countries_represented,
    count(distinct rating) as ratings_count,
    avg(case when type = 'Movie' then movie_duration_minutes end) as avg_movie_duration,
    avg(case when type = 'TV Show' then tv_show_seasons end) as avg_tv_seasons
from {{ ref('stg_netflix_titles') }}
where date_added_parsed is not null
group by date_added_parsed, month_added, year_added
order by date_added_parsed desc

