{{ config(materialized='view') }}

with source as (
    select * from {{ source('library_raw', 'books') }}
),

cleaned as (
    select
        book_id,
        title,
        author,
        isbn,
        genre,
        published_year,
        acquisition_date,
        current_status,
        shelf_location,
        date_part('year', current_date) - published_year as book_age_years,
        case 
            when date_part('year', current_date) - published_year < 10 then 'New'
            when date_part('year', current_date) - published_year between 10 and 50 then 'Modern'
            else 'Classic'
        end as book_age_category
    from source
)

select * from cleaned