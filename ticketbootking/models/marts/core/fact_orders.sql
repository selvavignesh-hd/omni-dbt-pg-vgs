-- Fact table for orders
-- This model creates a comprehensive fact table with datetime fields for order analytics

with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

events as (
    select * from {{ ref('stg_events') }}
),

orders_fact as (
    select
        -- Primary key
        o.order_id,
        
        -- Foreign keys
        o.customer_id,
        o.event_id,
        
        -- Order details
        o.order_number,
        o.order_status,
        o.payment_status,
        o.fulfillment_status,
        
        -- Financial information
        o.subtotal,
        o.tax_amount,
        o.discount_amount,
        o.shipping_fee,
        o.total_amount,
        o.currency,
        
        -- Timing information with datetime analysis
        o.order_date,
        o.order_datetime,
        o.payment_date,
        o.payment_datetime,
        o.fulfillment_date,
        o.fulfillment_datetime,
        o.cancellation_date,
        o.cancellation_datetime,
        
        -- Extracted datetime components for analysis
        date_trunc('day', o.order_datetime) as order_date_truncated,
        date_trunc('week', o.order_datetime) as order_week,
        date_trunc('month', o.order_datetime) as order_month,
        date_trunc('quarter', o.order_datetime) as order_quarter,
        date_trunc('year', o.order_datetime) as order_year,
        
        date_trunc('day', o.payment_datetime) as payment_date_truncated,
        date_trunc('week', o.payment_datetime) as payment_week,
        date_trunc('month', o.payment_datetime) as payment_month,
        date_trunc('quarter', o.payment_datetime) as payment_quarter,
        date_trunc('year', o.payment_datetime) as payment_year,
        
        -- Time analysis
        extract(dow from o.order_datetime) as order_day_of_week,
        extract(hour from o.order_datetime) as order_hour,
        extract(month from o.order_datetime) as order_month_num,
        extract(quarter from o.order_datetime) as order_quarter_num,
        extract(year from o.order_datetime) as order_year_num,
        
        extract(dow from o.payment_datetime) as payment_day_of_week,
        extract(hour from o.payment_datetime) as payment_hour,
        extract(month from o.payment_datetime) as payment_month_num,
        extract(quarter from o.payment_datetime) as payment_quarter_num,
        extract(year from o.payment_datetime) as payment_year_num,
        
        -- Season and time period analysis
        case 
            when extract(month from o.order_datetime) in (12, 1, 2) then 'Winter'
            when extract(month from o.order_datetime) in (3, 4, 5) then 'Spring'
            when extract(month from o.order_datetime) in (6, 7, 8) then 'Summer'
            when extract(month from o.order_datetime) in (9, 10, 11) then 'Fall'
        end as order_season,
        
        case 
            when extract(hour from o.order_datetime) between 6 and 11 then 'Morning'
            when extract(hour from o.order_datetime) between 12 and 17 then 'Afternoon'
            when extract(hour from o.order_datetime) between 18 and 22 then 'Evening'
            else 'Night'
        end as order_time_of_day,
        
        -- Payment information
        o.payment_method,
        o.payment_gateway,
        o.transaction_id,
        
        -- Customer information
        o.customer_name,
        o.customer_email,
        o.billing_address,
        o.shipping_address,
        
        -- Event information
        e.event_name,
        e.event_type,
        e.category,
        e.venue_name,
        e.venue_city,
        e.venue_state,
        e.venue_country,
        e.event_datetime,
        
        -- Customer information
        c.customer_tier,
        c.registration_date,
        c.total_orders,
        c.total_spent,
        
        -- Order metadata
        o.order_source,
        o.promo_code,
        o.notes,
        o.created_at,
        o.updated_at,
        
        -- Additional fields
        o.refund_amount,
        o.refund_date,
        o.refund_reason,
        o.order_priority,
        
        -- Business logic calculations
        case when o.discount_amount > 0 then true else false end as has_discount,
        case when o.refund_amount > 0 then true else false end as has_refund,
        case when o.order_status = 'completed' then true else false end as is_completed,
        case when o.order_status = 'cancelled' then true else false end as is_cancelled,
        case when o.payment_status = 'paid' then true else false end as is_paid,
        
        -- Time-based calculations
        o.payment_datetime - o.order_datetime as hours_between_order_and_payment,
        o.fulfillment_datetime - o.payment_datetime as hours_between_payment_and_fulfillment,
        e.event_datetime - o.order_datetime as days_between_order_and_event,
        
        -- Row metadata
        current_timestamp as dbt_updated_at,
        current_timestamp as dbt_created_at
        
    from orders o
    left join customers c on o.customer_id = c.customer_id
    left join events e on o.event_id = e.event_id
)

select * from orders_fact
