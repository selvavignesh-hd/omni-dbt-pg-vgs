{{ config(
    materialized='table',
    schema='netflix_analytics'
) }}

with director_expanded as (
    select
        s.show_id,
        s.type,
        s.title,
        s.release_year,
        s.rating,
        s.movie_duration_minutes,
        s.tv_show_seasons,
        trim(unnest(string_to_array(s.director, ','))) as director_name
    from {{ ref('stg_netflix_titles') }} s
    where s.director is not null and s.director != ''
)

select
    director_name as director,
    count(*) as total_content,
    count(distinct show_id) as unique_titles,
    count(case when type = 'Movie' then 1 end) as movies_count,
    count(case when type = 'TV Show' then 1 end) as tv_shows_count,
    min(release_year) as earliest_release_year,
    max(release_year) as latest_release_year,
    count(distinct release_year) as years_active,
    string_agg(distinct rating, ', ' order by rating) as ratings_used,
    round(avg(case when type = 'Movie' then movie_duration_minutes end), 2) as avg_movie_duration,
    round(avg(case when type = 'TV Show' then tv_show_seasons end), 2) as avg_tv_seasons
from director_expanded
group by director_name
having count(*) >= 2  -- Filter directors with at least 2 titles
order by total_content desc

