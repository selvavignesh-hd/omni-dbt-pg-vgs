---
title: Member Insights
---

# Member Activity & Insights

Comprehensive analysis of member behavior, activity patterns, and engagement metrics.

## Member Overview

```sql member_overview
select 
    count(*) as total_members,
    count(case when is_active then 1 end) as active_members,
    count(case when not is_active then 1 end) as inactive_members,
    round(avg(membership_years), 1) as avg_membership_years,
    count(case when membership_tier = 'premium' then 1 end) as premium_members,
    count(case when membership_tier = 'standard' then 1 end) as standard_members
from library.dim_members
```

<BigValue 
    data={member_overview} 
    title="Total Members" 
    value=total_members 
/>
<BigValue 
    data={member_overview} 
    title="Active Members" 
    value=active_members 
/>
<BigValue 
    data={member_overview} 
    title="Premium Members" 
    value=premium_members 
/>
<BigValue 
    data={member_overview} 
    title="Avg Membership Years" 
    value=avg_membership_years 
/>

## Membership Tier Distribution

```sql membership_tiers
select 
    membership_tier,
    count(*) as member_count,
    count(case when is_active then 1 end) as active_count,
    round(count(case when is_active then 1 end) * 100.0 / count(*), 1) as active_percentage,
    round(avg(membership_years), 1) as avg_years
from library.dim_members
group by membership_tier
order by member_count desc
```

<BarChart
    data={membership_tiers}
    title="Members by Tier"
    x=membership_tier
    y=member_count
    series=membership_tier
/>

## Member Activity Analysis

```sql member_activity_metrics
select 
    m.member_id,
    m.full_name,
    m.membership_tier,
    m.membership_years,
    m.is_active,
    count(l.loan_id) as total_loans,
    count(case when l.is_overdue then 1 end) as overdue_loans,
    count(case when l.was_returned_late then 1 end) as late_returns,
    round(avg(l.loan_duration_days), 1) as avg_loan_duration,
    round(sum(l.estimated_overdue_fine), 2) as total_fines,
    max(l.loan_date) as last_loan_date
from library.dim_members m
left join library.fct_book_loans l on m.member_id = l.member_id
group by m.member_id, m.full_name, m.membership_tier, m.membership_years, m.is_active
order by total_loans desc
```

<DataTable 
    data={member_activity_metrics}
    title="Member Activity Summary"
/>

---

## Navigation

- [Library Overview](/)
- [Book Analytics](/book-analytics)
- [Loan Trends](/loan-trends)
- [Genre Analysis](/genre-analysis)
