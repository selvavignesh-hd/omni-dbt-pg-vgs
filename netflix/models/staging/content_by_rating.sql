{{ config(
    materialized='table',
    schema='netflix_analytics'
) }}

select
    rating,
    count(*) as total_count,
    count(case when type = 'Movie' then 1 end) as movies_count,
    count(case when type = 'TV Show' then 1 end) as tv_shows_count,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage_of_total,
    min(release_year) as earliest_release_year,
    max(release_year) as latest_release_year,
    avg(case when type = 'Movie' then movie_duration_minutes end) as avg_movie_duration,
    avg(case when type = 'TV Show' then tv_show_seasons end) as avg_tv_seasons
from {{ ref('stg_netflix_titles') }}
where rating is not null and rating != ''
group by rating
order by total_count desc

