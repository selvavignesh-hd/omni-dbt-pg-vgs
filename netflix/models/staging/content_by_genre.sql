{{ config(
    materialized='table',
    schema='netflix_analytics'
) }}

with genre_expanded as (
    select
        s.show_id,
        s.type,
        s.title,
        s.release_year,
        s.rating,
        s.movie_duration_minutes,
        s.tv_show_seasons,
        trim(unnest(string_to_array(s.genres, ','))) as genre
    from {{ ref('stg_netflix_titles') }} s
    where s.genres is not null and s.genres != ''
)

select
    genre,
    count(*) as total_content,
    count(*) as total_content_from_local_change,
    count(distinct show_id) as unique_titles,
    count(case when type = 'Movie' then 1 end) as movies_count,
    count(case when type = 'TV Show' then 1 end) as tv_shows_count,
    count(distinct release_year) as years_spanned,
    min(release_year) as earliest_release_year,
    max(release_year) as latest_release_year,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage_of_total,
    round(avg(case when type = 'Movie' then movie_duration_minutes end), 2) as avg_movie_duration,
    round(avg(case when type = 'TV Show' then tv_show_seasons end), 2) as avg_tv_seasons
from genre_expanded
group by genre
order by total_content desc

