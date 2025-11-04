{{ config(
    materialized='view'
) }}

with source as (
    select * from {{ source('public', 'netflix_titles') }}
),

renamed as (
    select
        show_id,
        type,
        title,
        director,
        casts,
        country,
        date_added,
        release_year,
        rating,
        duration,
        listed_in as genres,
        description,
        -- Parse duration into numeric values
        case 
            when type = 'Movie' then 
                cast(regexp_replace(duration, '[^0-9]', '', 'g') as integer)
            else null
        end as movie_duration_minutes,
        case 
            when type = 'TV Show' then 
                cast(regexp_replace(duration, '[^0-9]', '', 'g') as integer)
            else null
        end as tv_show_seasons,
        -- date_added is already in date format, use it directly
        date_added as date_added_parsed
    from source
)

select * from renamed

