{{ config(
    materialized='table'
) }}

select
    'Total Content' as metric,
    count(*) as value
from {{ ref('stg_netflix_titles') }}

union all

select
    'Total Movies' as metric,
    count(*) as value
from {{ ref('stg_netflix_titles') }}
where type = 'Movie'

union all

select
    'Total TV Shows' as metric,
    count(*) as value
from {{ ref('stg_netflix_titles') }}
where type = 'TV Show'

union all

select
    'Unique Countries' as metric,
    count(distinct country) as value
from {{ ref('stg_netflix_titles') }}
where country is not null and country != ''

union all

select
    'Unique Directors' as metric,
    count(distinct director) as value
from {{ ref('stg_netflix_titles') }}
where director is not null and director != ''

union all

select
    'Earliest Release Year' as metric,
    min(release_year) as value
from {{ ref('stg_netflix_titles') }}
where release_year is not null

union all

select
    'Latest Release Year' as metric,
    max(release_year) as value
from {{ ref('stg_netflix_titles') }}
where release_year is not null

union all

select
    'Average Movie Duration (minutes)' as metric,
    round(avg(movie_duration_minutes), 2) as value
from {{ ref('stg_netflix_titles') }}
where type = 'Movie' and movie_duration_minutes is not null

union all

select
    'Average TV Show Seasons' as metric,
    round(avg(tv_show_seasons), 2) as value
from {{ ref('stg_netflix_titles') }}
where type = 'TV Show' and tv_show_seasons is not null

union all

select
    'Content Added Last 30 Days' as metric,
    count(*) as value
from {{ ref('stg_netflix_titles') }}
where date_added_parsed >= current_date - interval '30 days'

union all

select
    'Content Added Last Year' as metric,
    count(*) as value
from {{ ref('stg_netflix_titles') }}
where date_added_parsed >= current_date - interval '1 year'

