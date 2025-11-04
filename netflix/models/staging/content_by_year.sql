{{ config(
    materialized='table',
    schema='netflix_analytics'
) }}

select
    release_year,
    count(*) as total_content,
    count(case when type = 'Movie' then 1 end) as movies_count,
    count(case when type = 'TV Show' then 1 end) as tv_shows_count,
    count(distinct country) as countries_count,
    count(distinct rating) as ratings_count,
    avg(case when type = 'Movie' then movie_duration_minutes end) as avg_movie_duration,
    avg(case when type = 'TV Show' then tv_show_seasons end) as avg_tv_seasons
from {{ ref('stg_netflix_titles') }}
where release_year is not null
group by release_year
order by release_year desc

