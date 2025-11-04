with player_data as (
    select * from {{ ref('player_selection') }}
)

select 
    area_clean as area,
    region,
    count(*) as total_players,
    count(case when status_clean = 'APPLIED' then 1 end) as applied_count,
    count(case when status_clean = 'PROCESSING' then 1 end) as processing_count,
    count(case when status_clean = 'APPROVED' then 1 end) as approved_count,
    count(case when status_clean = 'REJECTED' then 1 end) as rejected_count,
    round(count(case when status_clean = 'APPLIED' then 1 end) * 100.0 / count(*), 2) as applied_pct,
    round(count(case when status_clean = 'PROCESSING' then 1 end) * 100.0 / count(*), 2) as processing_pct,
    round(count(case when status_clean = 'APPROVED' then 1 end) * 100.0 / count(*), 2) as approved_pct,
    round(count(case when status_clean = 'REJECTED' then 1 end) * 100.0 / count(*), 2) as rejected_pct,    
    round(
        count(case when status_clean = 'APPROVED' then 1 end) * 100.0 / 
        nullif(count(case when status_clean in ('APPROVED', 'REJECTED') then 1 end), 0), 
        2
    ) as approval_rate,
    max(updated_at) as latest_update,
    count(case when recency_flag = 'RECENT' then 1 end) as recent_count,
    count(case when recency_flag = 'MONTHLY' then 1 end) as monthly_count,
    count(case when recency_flag = 'OLDER' then 1 end) as older_count

from player_data
group by area_clean, region
order by total_players desc
