{{ config(materialized='table') }}

select
    loan_year,
    loan_month,
    loan_month_name,
    count(*) as total_loans,
    count(distinct member_id) as active_members,
    count(distinct book_id) as unique_books_borrowed,
    count(case when is_overdue then 1 end) as overdue_loans,
    count(case when renewal_count > 0 then 1 end) as renewed_loans,
    avg(loan_duration_days) as avg_loan_duration
from {{ ref('fct_book_loans') }}
group by loan_year, loan_month, loan_month_name
order by loan_year, loan_month