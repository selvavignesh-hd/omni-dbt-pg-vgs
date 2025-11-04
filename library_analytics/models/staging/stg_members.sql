{{ config(materialized='view') }}

with source as (
    select * from {{ source('library_raw', 'members') }}
),

cleaned as (
    select
        member_id,
        first_name,
        last_name,
        email,
        membership_tier,
        join_date,
        is_active,
        date_part('year', current_date) - date_part('year', join_date) as membership_years,
        first_name || ' ' || last_name as full_name
    from source
)

select * from cleaned