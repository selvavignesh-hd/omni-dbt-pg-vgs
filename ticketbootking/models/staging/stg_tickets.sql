-- Staging model for tickets table
-- This model cleans and standardizes the raw tickets data

with source_data as (
    select * from {{ source('ticket_booking', 'tickets') }}
),

renamed as (
    select
        -- Primary key
        ticket_id,
        
        -- Foreign keys
        event_id,
        customer_id,
        order_id,
        
        -- Ticket details
        ticket_type,
        seat_number,
        row_number,
        section,
        price_paid,
        currency,
        
        -- Status and timing
        status,
        booking_status,
        purchase_date,
        purchase_datetime,
        booking_date,
        booking_datetime,
        
        -- Customer information
        customer_name,
        customer_email,
        customer_phone,
        
        -- Additional fields
        discount_applied,
        discount_amount,
        final_price,
        payment_method,
        payment_status,
        refund_status,
        refund_date,
        refund_amount,
        
        -- Metadata
        created_at,
        updated_at,
        booking_source,
        promo_code_used
        
    from source_data
)

select * from renamed
