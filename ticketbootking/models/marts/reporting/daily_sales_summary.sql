-- Daily sales summary report
-- This model provides daily aggregated sales metrics with comprehensive datetime analysis

with daily_sales as (
    select
        -- Date dimensions
        purchase_date_truncated as sale_date,
        purchase_week,
        purchase_month,
        purchase_quarter,
        purchase_year,
        purchase_day_of_week,
        purchase_hour,
        purchase_season,
        purchase_time_of_day,
        
        -- Event dimensions
        event_type,
        category,
        venue_city,
        venue_state,
        venue_country,
        
        -- Customer dimensions
        customer_tier,
        
        -- Aggregated metrics
        count(distinct ticket_id) as total_tickets_sold,
        count(distinct customer_id) as unique_customers,
        count(distinct event_id) as unique_events,
        count(distinct order_id) as unique_orders,
        
        sum(final_price) as total_revenue,
        sum(discount_amount) as total_discounts,
        sum(gross_price) as gross_revenue,
        avg(final_price) as avg_ticket_price,
        median(final_price) as median_ticket_price,
        
        -- Count metrics
        count(case when has_discount = true then 1 end) as tickets_with_discount,
        count(case when is_refunded = true then 1 end) as tickets_refunded,
        count(case when is_active_ticket = true then 1 end) as active_tickets,
        
        -- Financial metrics
        sum(case when is_refunded = true then refund_amount else 0 end) as total_refunds,
        sum(case when has_discount = true then discount_amount else 0 end) as total_discount_amount,
        
        -- Time-based metrics
        avg(days_between_purchase_and_event) as avg_days_advance_purchase,
        min(days_between_purchase_and_event) as min_days_advance_purchase,
        max(days_between_purchase_and_event) as max_days_advance_purchase,
        
        -- Conversion metrics
        count(case when booking_status = 'confirmed' then 1 end) as confirmed_bookings,
        count(case when booking_status = 'pending' then 1 end) as pending_bookings,
        count(case when booking_status = 'cancelled' then 1 end) as cancelled_bookings,
        
        -- Row metadata
        current_timestamp as dbt_updated_at
        
    from {{ ref('fact_ticket_sales') }}
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
)

select * from daily_sales
