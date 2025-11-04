with player_data as (
    select * from {{ ref('player_selection') }}
)

select 
    count(*) as total_players,
    count(distinct area_clean) as total_areas,
    count(distinct region) as total_regions,
    count(case when status_clean = 'APPLIED' then 1 end) as applied_count,
    count(case when status_clean = 'PROCESSING' then 1 end) as processing_count,
    count(case when status_clean = 'APPROVED' then 1 end) as approved_count,
    count(case when status_clean = 'REJECTED' then 1 end) as rejected_count,
    round(count(case when status_clean = 'APPLIED' then 1 end) * 100.0 / count(*), 2) as applied_pct,
    round(count(case when status_clean = 'PROCESSING' then 1 end) * 100.0 / count(*), 2) as processing_pct,
    round(count(case when status_clean = 'APPROVED' then 1 end) * 100.0 / count(*), 2) as approved_pct,
    round(count(case when status_clean = 'REJECTED' then 1 end) * 100.0 / count(*), 2) as rejected_pct,
    count(case when status_category = 'ACTIVE' then 1 end) as active_count,
    count(case when status_category = 'PENDING' then 1 end) as pending_count,
    count(case when status_category = 'INACTIVE' then 1 end) as inactive_count,
    count(case when recency_flag = 'RECENT' then 1 end) as recent_count,
    count(case when recency_flag = 'MONTHLY' then 1 end) as monthly_count,
    count(case when recency_flag = 'OLDER' then 1 end) as older_count,
    min(updated_at) as earliest_update,
    max(updated_at) as latest_update,
    datediff('day', min(updated_at), max(updated_at)) as days_span

from player_data
