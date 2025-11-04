-- Fact table for ticket sales
-- This model creates a comprehensive fact table with datetime fields for ticket sales analytics

with tickets as (
    select * from {{ ref('stg_tickets') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

events as (
    select * from {{ ref('stg_events') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

ticket_sales_fact as (
    select
        -- Primary key
        t.ticket_id,
        
        -- Foreign keys
        t.event_id,
        t.customer_id,
        t.order_id,
        
        -- Ticket details
        t.ticket_type,
        t.seat_number,
        t.row_number,
        t.section,
        t.price_paid,
        t.currency,
        
        -- Status and timing
        t.status,
        t.booking_status,
        t.purchase_date,
        t.purchase_datetime,
        t.booking_date,
        t.booking_datetime,
        
        -- Extracted datetime components for analysis
        date_trunc('day', t.purchase_datetime) as purchase_date_truncated,
        date_trunc('week', t.purchase_datetime) as purchase_week,
        date_trunc('month', t.purchase_datetime) as purchase_month,
        date_trunc('quarter', t.purchase_datetime) as purchase_quarter,
        date_trunc('year', t.purchase_datetime) as purchase_year,
        
        date_trunc('day', t.booking_datetime) as booking_date_truncated,
        date_trunc('week', t.booking_datetime) as booking_week,
        date_trunc('month', t.booking_datetime) as booking_month,
        date_trunc('quarter', t.booking_datetime) as booking_quarter,
        date_trunc('year', t.booking_datetime) as booking_year,
        
        -- Time analysis
        extract(dow from t.purchase_datetime) as purchase_day_of_week,
        extract(hour from t.purchase_datetime) as purchase_hour,
        extract(month from t.purchase_datetime) as purchase_month_num,
        extract(quarter from t.purchase_datetime) as purchase_quarter_num,
        extract(year from t.purchase_datetime) as purchase_year_num,
        
        extract(dow from t.booking_datetime) as booking_day_of_week,
        extract(hour from t.booking_datetime) as booking_hour,
        extract(month from t.booking_datetime) as booking_month_num,
        extract(quarter from t.booking_datetime) as booking_quarter_num,
        extract(year from t.booking_datetime) as booking_year_num,
        
        -- Season and time period analysis
        case 
            when extract(month from t.purchase_datetime) in (12, 1, 2) then 'Winter'
            when extract(month from t.purchase_datetime) in (3, 4, 5) then 'Spring'
            when extract(month from t.purchase_datetime) in (6, 7, 8) then 'Summer'
            when extract(month from t.purchase_datetime) in (9, 10, 11) then 'Fall'
        end as purchase_season,
        
        case 
            when extract(hour from t.purchase_datetime) between 6 and 11 then 'Morning'
            when extract(hour from t.purchase_datetime) between 12 and 17 then 'Afternoon'
            when extract(hour from t.purchase_datetime) between 18 and 22 then 'Evening'
            else 'Night'
        end as purchase_time_of_day,
        
        -- Customer information
        t.customer_name,
        t.customer_email,
        t.customer_phone,
        
        -- Financial information
        t.discount_applied,
        t.discount_amount,
        t.final_price,
        t.payment_method,
        t.payment_status,
        t.refund_status,
        t.refund_date,
        t.refund_amount,
        
        -- Event information
        e.event_name,
        e.event_type,
        e.category,
        e.venue_name,
        e.venue_city,
        e.venue_state,
        e.venue_country,
        e.event_datetime,
        e.base_price,
        
        -- Customer information
        c.customer_tier,
        c.registration_date,
        c.total_orders,
        c.total_spent,
        
        -- Order information
        o.order_status,
        o.payment_status as order_payment_status,
        o.total_amount as order_total_amount,
        o.order_date,
        o.order_datetime,
        
        -- Business logic calculations
        t.final_price - t.discount_amount as gross_price,
        case when t.discount_amount > 0 then true else false end as has_discount,
        case when t.refund_status = 'refunded' then true else false end as is_refunded,
        case when t.status = 'active' then true else false end as is_active_ticket,
        
        -- Time-based calculations
        e.event_datetime - t.purchase_datetime as days_between_purchase_and_event,
        t.purchase_datetime - t.booking_datetime as hours_between_booking_and_purchase,
        
        -- Row metadata
        t.created_at,
        t.updated_at,
        t.booking_source,
        t.promo_code_used,
        current_timestamp as dbt_updated_at,
        current_timestamp as dbt_created_at
        
    from tickets t
    left join orders o on t.order_id = o.order_id
    left join events e on t.event_id = e.event_id
    left join customers c on t.customer_id = c.customer_id
)

select * from ticket_sales_fact
