{{ config(materialized='view') }}

with source as (
    select * from {{ source('library_raw', 'loans') }}
),

cleaned as (
    select
        loan_id,
        book_id,
        member_id,
        loan_date,
        due_date,
        return_date,
        renewal_count,
        case 
            when return_date is not null then return_date - loan_date
            else current_date - loan_date
        end as loan_duration_days,
        case 
            when return_date is null and current_date > due_date then true
            else false
        end as is_overdue,
        case 
            when return_date > due_date then true
            else false
        end as was_returned_late
    from source
)

select * from cleaned