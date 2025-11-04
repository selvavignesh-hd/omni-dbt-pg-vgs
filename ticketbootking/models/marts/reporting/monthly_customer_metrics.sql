-- Monthly customer metrics report
-- This model provides monthly aggregated customer engagement and lifecycle metrics

with monthly_customer_metrics as (
    select
        -- Date dimensions
        date_trunc('month', registration_datetime) as registration_month,
        date_trunc('quarter', registration_datetime) as registration_quarter,
        date_trunc('year', registration_datetime) as registration_year,
        
        date_trunc('month', last_login_datetime) as last_login_month,
        date_trunc('quarter', last_login_datetime) as last_login_quarter,
        date_trunc('year', last_login_datetime) as last_login_year,
        
        date_trunc('month', last_purchase_datetime) as last_purchase_month,
        date_trunc('quarter', last_purchase_datetime) as last_purchase_quarter,
        date_trunc('year', last_purchase_datetime) as last_purchase_year,
        
        -- Customer dimensions
        customer_tier,
        customer_lifecycle_stage,
        gender,
        state,
        country,
        
        -- Aggregated metrics
        count(distinct customer_id) as total_customers,
        count(distinct case when is_fully_verified = true then customer_id end) as verified_customers,
        count(distinct case when is_marketing_subscriber = true then customer_id end) as marketing_subscribers,
        count(distinct case when has_made_purchase = true then customer_id end) as customers_with_purchases,
        
        -- Engagement metrics
        avg(total_orders) as avg_orders_per_customer,
        avg(total_spent) as avg_spent_per_customer,
        avg(loyalty_points) as avg_loyalty_points,
        avg(days_since_registration) as avg_days_since_registration,
        avg(days_since_last_login) as avg_days_since_last_login,
        avg(days_since_last_purchase) as avg_days_since_last_purchase,
        
        -- Financial metrics
        sum(total_spent) as total_customer_spend,
        sum(total_orders) as total_customer_orders,
        sum(loyalty_points) as total_loyalty_points,
        
        -- Customer lifecycle distribution
        count(case when customer_lifecycle_stage = 'Active' then 1 end) as active_customers,
        count(case when customer_lifecycle_stage = 'At Risk' then 1 end) as at_risk_customers,
        count(case when customer_lifecycle_stage = 'Inactive' then 1 end) as inactive_customers,
        count(case when customer_lifecycle_stage = 'Churned' then 1 end) as churned_customers,
        
        -- Row metadata
        current_timestamp as dbt_updated_at
        
    from {{ ref('dim_customers') }}
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
)

select * from monthly_customer_metrics
