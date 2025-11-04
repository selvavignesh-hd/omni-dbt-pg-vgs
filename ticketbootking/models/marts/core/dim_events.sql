-- Dimension table for events
-- This model creates a comprehensive events dimension with datetime fields for analytics

with events as (
    select * from {{ ref('stg_events') }}
),

events_with_datetime_fields as (
    select
        -- Primary key
        event_id,
        
        -- Event details
        event_name,
        event_description,
        event_type,
        category,
        
        -- Venue information
        venue_id,
        venue_name,
        venue_city,
        venue_state,
        venue_country,
        venue_capacity,
        
        -- Event timing - multiple datetime formats for flexibility
        event_date,
        event_time,
        event_datetime,
        duration_minutes,
        
        -- Extracted datetime components for analysis
        date_trunc('day', event_datetime) as event_date_truncated,
        date_trunc('week', event_datetime) as event_week,
        date_trunc('month', event_datetime) as event_month,
        date_trunc('quarter', event_datetime) as event_quarter,
        date_trunc('year', event_datetime) as event_year,
        
        -- Day of week and time analysis
        extract(dow from event_datetime) as day_of_week,
        extract(hour from event_datetime) as event_hour,
        extract(month from event_datetime) as event_month_num,
        extract(quarter from event_datetime) as event_quarter_num,
        extract(year from event_datetime) as event_year_num,
        
        -- Season and time period analysis
        case 
            when extract(month from event_datetime) in (12, 1, 2) then 'Winter'
            when extract(month from event_datetime) in (3, 4, 5) then 'Spring'
            when extract(month from event_datetime) in (6, 7, 8) then 'Summer'
            when extract(month from event_datetime) in (9, 10, 11) then 'Fall'
        end as season,
        
        case 
            when extract(hour from event_datetime) between 6 and 11 then 'Morning'
            when extract(hour from event_datetime) between 12 and 17 then 'Afternoon'
            when extract(hour from event_datetime) between 18 and 22 then 'Evening'
            else 'Night'
        end as time_of_day,
        
        -- Pricing
        base_price,
        currency,
        
        -- Status and metadata
        status,
        is_cancelled,
        created_at,
        updated_at,
        
        -- Additional fields
        organizer_id,
        organizer_name,
        max_tickets_per_person,
        age_restriction,
        
        -- Business logic flags
        case when event_datetime > current_timestamp then true else false end as is_future_event,
        case when event_datetime < current_timestamp then true else false end as is_past_event,
        case when event_datetime::date = current_date then true else false end as is_today_event,
        
        -- Row metadata
        current_timestamp as dbt_updated_at,
        current_timestamp as dbt_created_at
        
    from events
)

select * from events_with_datetime_fields
