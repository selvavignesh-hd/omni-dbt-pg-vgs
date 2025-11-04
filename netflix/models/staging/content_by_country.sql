{{ config(
    materialized='table',
    schema='netflix_analytics'
) }}

with country_expanded as (
    select
        show_id,
        type,
        title,
        release_year,
        rating,
        trim(unnest(string_to_array(country, ','))) as country_name
    from {{ ref('stg_netflix_titles') }}
    where country is not null and country != ''
)

select
    country_name as country,
    country_name as country_fullname,
    count(*) as total_content,
    count(distinct show_id) as unique_titles,
    count(case when type = 'Movie' then 1 end) as movies_count,
    count(case when type = 'TV Show' then 1 end) as tv_shows_count,
    count(distinct release_year) as years_spanned,
    min(release_year) as earliest_release_year,
    max(release_year) as latest_release_year,
    round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage_of_total
from country_expanded
group by country_name
having count(*) >= 5  -- Filter countries with at least 5 titles
order by total_content desc

