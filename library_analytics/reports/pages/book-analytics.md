---
title: Book Analytics
---

# Book Analytics Dashboard

Book performance, popularity trends, and circulation patterns.

## Book Inventory Overview

```sql book_inventory
select 
    current_status,
    count(*) as book_count,
    round(count(*) * 100.0 / sum(count(*)) over(), 1) as percentage
from library.dim_books
group by current_status
order by book_count desc
```

<BigValue 
    data={book_inventory} 
    title="Available Books" 
    value=book_count 
    where="current_status = 'available'"
/>
<BigValue 
    data={book_inventory} 
    title="Borrowed Books" 
    value=book_count 
    where="current_status = 'borrowed'"
/>
<BigValue 
    data={book_inventory} 
    title="In Maintenance" 
    value=book_count 
    where="current_status = 'maintenance'"
/>

## Popularity Rankings

```sql popularity_breakdown
select 
    popularity_rating,
    count(*) as book_count,
    round(avg(total_loans), 1) as avg_loans,
    round(avg(avg_loan_duration), 1) as avg_duration_days
from library.dim_books
group by popularity_rating
order by 
    case popularity_rating
        when 'High' then 1
        when 'Medium' then 2
        when 'Low' then 3
        when 'Never Borrowed' then 4
    end
```

<BarChart
    data={popularity_breakdown}
    title="Books by Popularity Rating"
    x=popularity_rating
    y=book_count
    series=popularity_rating
/>

## Top Performers

```sql top_books
select 
    title,
    author,
    genre,
    total_loans,
    popularity_rating,
    round(avg_loan_duration, 1) as avg_duration_days,
    times_overdue,
    book_age_category
from library.dim_books
where total_loans > 0
order by total_loans desc
limit 15
```

<DataTable 
    data={top_books}
    title="Top 15 Most Borrowed Books"
/>

---

## Navigation

- [Library Overview](/)
- [Member Insights](/member-insights)
- [Loan Trends](/loan-trends)
- [Genre Analysis](/genre-analysis)
