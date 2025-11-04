-- Staging model for events table
-- This model cleans and standardizes the raw events data

with source_data as (
    select * from {{ source('ticket_booking', 'events') }}
),

renamed as (
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
        
        -- Event timing
        event_date,
        event_time,
        event_datetime,
        duration_minutes,
        
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
        age_restriction
        
    from source_data
)

select * from renamed
