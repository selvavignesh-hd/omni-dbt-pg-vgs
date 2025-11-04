{{ config(materialized='table') }}

with loans as (
    select * from {{ ref('fct_book_loans') }}
),

books as (
    select * from {{ ref('stg_books') }}
),

genre_stats as (
    select
        b.genre,
        count(distinct b.book_id) as total_books,
        count(distinct l.loan_id) as total_loans,
        count(distinct case when l.is_overdue then l.loan_id end) as overdue_loans,
        avg(l.loan_duration_days) as avg_loan_duration,
        count(distinct l.member_id) as unique_borrowers
    from books b
    left join loans l on b.book_id = l.book_id
    group by b.genre
)

select
    genre,
    total_books,
    total_loans,
    overdue_loans,
    round(avg_loan_duration, 2) as avg_loan_duration,
    unique_borrowers,
    case 
        when total_books > 0 then round(total_loans::decimal / total_books, 2)
        else 0
    end as loans_per_book,
    case 
        when total_loans > 0 then round(overdue_loans::decimal / total_loans * 100, 2)
        else 0
    end as overdue_rate_percent
from genre_stats
order by total_loans desc