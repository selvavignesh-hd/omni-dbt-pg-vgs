{{ config(materialized='table') }}

with members as (
    select * from {{ ref('stg_members') }}
),

member_metrics as (
    select 
        member_id,
        count(*) as total_loans,
        count(case when is_overdue then 1 end) as overdue_loans,
        count(case when was_returned_late then 1 end) as late_returns,
        sum(renewal_count) as total_renewals,
        avg(loan_duration_days) as avg_loan_duration,
        max(loan_date) as last_loan_date
    from {{ ref('fct_book_loans') }}
    group by member_id
)

select
    m.member_id,
    m.full_name,
    m.email,
    m.membership_tier,
    m.join_date,
    m.is_active,
    m.membership_years,
    
    coalesce(mm.total_loans, 0) as total_loans,
    coalesce(mm.overdue_loans, 0) as overdue_loans,
    coalesce(mm.late_returns, 0) as late_returns,
    coalesce(mm.total_renewals, 0) as total_renewals,
    mm.avg_loan_duration,
    mm.last_loan_date,
    
    case 
        when mm.total_loans = 0 then 'New'
        when mm.overdue_loans = 0 and mm.late_returns = 0 then 'Excellent'
        when mm.overdue_loans <= 1 and mm.late_returns <= 2 then 'Good'
        when mm.overdue_loans <= 3 and mm.late_returns <= 5 then 'Fair'
        else 'Poor'
    end as reliability_rating,
    
    case 
        when mm.total_loans >= 10 then 'Very Active'
        when mm.total_loans >= 5 then 'Active'
        when mm.total_loans >= 1 then 'Occasional'
        else 'Inactive'
    end as activity_level
    
from members m
left join member_metrics mm on m.member_id = mm.member_id   