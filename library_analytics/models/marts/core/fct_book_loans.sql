{{ config(materialized='table') }}

with loans as (
    select * from {{ ref('stg_loans') }}
),

books as (
    select * from {{ ref('stg_books') }}
),

members as (
    select * from {{ ref('stg_members') }}
),

enriched_loans as (
    select
        l.loan_id,
        l.book_id,
        l.member_id,
        l.loan_date,
        l.due_date,
        l.return_date,
        l.renewal_count,
        l.loan_duration_days,
        l.is_overdue,
        l.was_returned_late,
        b.title,
        b.author,
        b.genre,
        {{ calculate_overdue_fine('greatest(0, current_date - l.due_date)', 'm.membership_tier') }} as estimated_overdue_fine,
        b.book_age_category,
        m.full_name as member_name,
        m.membership_tier,
        m.membership_years,
        date_part('year', l.loan_date) as loan_year,
        date_part('month', l.loan_date) as loan_month,
        to_char(l.loan_date, 'Month') as loan_month_name,
        date_part('dow', l.loan_date) as loan_day_of_week
        
    from loans l
    left join books b on l.book_id = b.book_id
    left join members m on l.member_id = m.member_id
)

select * from enriched_loans