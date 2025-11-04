{{ config(materialized='table') }}

with books as (
    select * from {{ ref('stg_books') }}
),

loan_metrics as (
    select 
        book_id,
        count(*) as total_loans,
        count(case when is_overdue then 1 end) as times_overdue,
        count(case when was_returned_late then 1 end) as times_returned_late,
        max(renewal_count) as max_renewals,
        avg(loan_duration_days) as avg_loan_duration
    from {{ ref('fct_book_loans') }}
    group by book_id
)

select
    b.book_id,
    b.title,
    b.author,
    b.isbn,
    b.genre,
    b.published_year,
    b.acquisition_date,
    b.current_status,
    b.shelf_location,
    b.book_age_years,
    b.book_age_category,
    coalesce(lm.total_loans, 0) as total_loans,
    coalesce(lm.times_overdue, 0) as times_overdue,
    coalesce(lm.times_returned_late, 0) as times_returned_late,
    coalesce(lm.max_renewals, 0) as max_renewals,
    lm.avg_loan_duration,
    
    case 
        when coalesce(lm.total_loans, 0) = 0 then 'Never Borrowed'
        when lm.total_loans <= 2 then 'Low'
        when lm.total_loans <= 5 then 'Medium'
        else 'High'
    end as popularity_rating
    
from books b
left join loan_metrics lm on b.book_id = lm.book_id