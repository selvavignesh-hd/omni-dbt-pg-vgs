-- Staging model for orders table
-- This model cleans and standardizes the raw orders data

with source_data as (
    select * from {{ source('ticket_booking', 'orders') }}
),

renamed as (
    select
        -- Primary key
        order_id,
        
        -- Foreign keys
        customer_id,
        event_id,
        
        -- Order details
        order_number,
        order_status,
        payment_status,
        fulfillment_status,
        
        -- Financial information
        subtotal,
        tax_amount,
        discount_amount,
        shipping_fee,
        total_amount,
        currency,
        
        -- Timing information
        order_date,
        order_datetime,
        payment_date,
        payment_datetime,
        fulfillment_date,
        fulfillment_datetime,
        cancellation_date,
        cancellation_datetime,
        
        -- Payment information
        payment_method,
        payment_gateway,
        transaction_id,
        
        -- Customer information
        customer_name,
        customer_email,
        billing_address,
        shipping_address,
        
        -- Order metadata
        order_source,
        promo_code,
        notes,
        created_at,
        updated_at,
        
        -- Additional fields
        refund_amount,
        refund_date,
        refund_reason,
        order_priority
        
    from source_data
)

select * from renamed
