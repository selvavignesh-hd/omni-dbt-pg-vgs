---
title: Library Analytics Dashboard
---

# 📚 Library Analytics Overview

Welcome to the Library Dashboard!

## 📊 Key Metrics

```sql library_overview
select 
    count(distinct book_id) as total_books,
    count(distinct member_id) as total_members,
    count(distinct loan_id) as total_loans,
    count(distinct case when is_overdue then loan_id end) as current_overdue_loans,
    round(avg(loan_duration_days), 1) as avg_loan_duration_days,
    count(distinct case when was_returned_late then loan_id end) as total_late_returns
from library.fct_book_loans
```

<BigValue 
    data={library_overview} 
    title="Total Books" 
    value=total_books 
/>
<BigValue 
    data={library_overview} 
    title="Active Members" 
    value=total_members 
/>
<BigValue 
    data={library_overview} 
    title="Total Loans" 
    value=total_loans 
/>
<BigValue 
    data={library_overview} 
    title="Overdue Loans" 
    value=current_overdue_loans 
/>

## Loan Activity Trends

```sql monthly_loans
select 
    date_trunc('month', loan_date) as month,
    count(*) as loan_count,
    count(distinct member_id) as unique_borrowers,
    count(distinct book_id) as unique_books_borrowed
from library.fct_book_loans
group by date_trunc('month', loan_date)
order by month
```

<LineChart
    data={monthly_loans}
    title="Monthly Loan Activity"
    x=month
    y=loan_count
    series=loan_count
/>

## Top Performing Books

```sql popular_books
select 
    title,
    author,
    genre,
    total_loans,
    popularity_rating,
    avg_loan_duration,
    times_overdue
from library.dim_books
where total_loans > 0
order by total_loans desc
limit 10
```
<!-- total_loans, author, popularity_rating -->

<DataTable 
    data={popular_books}
    title="Most Popular Books"
/>

## Genre Performance

```sql genre_performance
select 
    genre,
    total_books,
    total_loans,
    round(loans_per_book, 2) as loans_per_book,
    round(overdue_rate_percent, 1) as overdue_rate_percent,
    unique_borrowers
from library.genre_analysis
order by total_loans desc
```

<BarChart
    data={genre_performance}
    title="Loans by Genre"
    x=genre
    y=total_loans
    series=genre
/>

## Member Activity

```sql member_activity
select 
    membership_tier,
    count(*) as member_count,
    count(case when is_active then 1 end) as active_members,
    round(avg(membership_years), 1) as avg_membership_years
from library.dim_members
group by membership_tier
order by member_count desc
```

<BarChart
    data={member_activity}
    title="Members by Tier"
    x=membership_tier
    y=member_count
    series=membership_tier
/>

## Overdue Analysis

```sql overdue_analysis
select 
    case 
        when is_overdue then 'Currently Overdue'
        when was_returned_late then 'Returned Late'
        else 'On Time'
    end as loan_status,
    count(*) as loan_count,
    round(avg(estimated_overdue_fine), 2) as avg_fine
from library.fct_book_loans
group by 
    case 
        when is_overdue then 'Currently Overdue'
        when was_returned_late then 'Returned Late'
        else 'On Time'
    end
order by loan_count desc
```

<BarChart
    data={overdue_analysis}
    title="Loan Status Distribution"
    category=loan_status
    value=loan_count
/>

---

## 🔗 Navigation

- [Book analytics](/book-analytics) - Detailed book performance metrics
- [Member](/member-insights) - Member activity and behavior analysis  
- [Loan details](/loan-trends) - Loan patterns and overdue analysis
- [Genre](/genre-analysis) - Genre performance and trends