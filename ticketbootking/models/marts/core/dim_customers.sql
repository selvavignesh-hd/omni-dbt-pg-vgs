-- Dimension table for customers
-- This model creates a comprehensive customers dimension with datetime fields for analytics

with customers as (
    select * from {{ ref('stg_customers') }}
),

customers_with_datetime_fields as (
    select
        -- Primary key
        customer_id,
        
        -- Personal information
        first_name,
        last_name,
        full_name,
        email,
        phone,
        date_of_birth,
        age,
        gender,
        
        -- Address information
        address_line_1,
        address_line_2,
        city,
        state,
        country,
        postal_code,
        
        -- Customer preferences
        preferred_language,
        notification_preferences,
        marketing_opt_in,
        
        -- Customer status and metadata
        customer_status,
        customer_tier,
        registration_date,
        registration_datetime,
        last_login_date,
        last_login_datetime,
        last_purchase_date,
        last_purchase_datetime,
        
        -- Extracted datetime components for analysis
        date_trunc('day', registration_datetime) as registration_date_truncated,
        date_trunc('week', registration_datetime) as registration_week,
        date_trunc('month', registration_datetime) as registration_month,
        date_trunc('quarter', registration_datetime) as registration_quarter,
        date_trunc('year', registration_datetime) as registration_year,
        
        date_trunc('day', last_login_datetime) as last_login_date_truncated,
        date_trunc('week', last_login_datetime) as last_login_week,
        date_trunc('month', last_login_datetime) as last_login_month,
        date_trunc('quarter', last_login_datetime) as last_login_quarter,
        date_trunc('year', last_login_datetime) as last_login_year,
        
        date_trunc('day', last_purchase_datetime) as last_purchase_date_truncated,
        date_trunc('week', last_purchase_datetime) as last_purchase_week,
        date_trunc('month', last_purchase_datetime) as last_purchase_month,
        date_trunc('quarter', last_purchase_datetime) as last_purchase_quarter,
        date_trunc('year', last_purchase_datetime) as last_purchase_year,
        
        -- Customer lifecycle analysis
        current_date - registration_date::date as days_since_registration,
        current_date - last_login_date::date as days_since_last_login,
        current_date - last_purchase_date::date as days_since_last_purchase,
        
        -- Customer segmentation based on recency
        case 
            when last_purchase_date::date >= current_date - interval '30 days' then 'Active'
            when last_purchase_date::date >= current_date - interval '90 days' then 'At Risk'
            when last_purchase_date::date >= current_date - interval '180 days' then 'Inactive'
            else 'Churned'
        end as customer_lifecycle_stage,
        
        -- Loyalty and engagement
        total_orders,
        total_spent,
        loyalty_points,
        referral_code,
        referred_by,
        
        -- Account information
        account_status,
        email_verified,
        phone_verified,
        created_at,
        updated_at,
        
        -- Business logic flags
        case when email_verified = true and phone_verified = true then true else false end as is_fully_verified,
        case when marketing_opt_in = true then true else false end as is_marketing_subscriber,
        case when total_orders > 0 then true else false end as has_made_purchase,
        
        -- Row metadata
        current_timestamp as dbt_updated_at,
        current_timestamp as dbt_created_at
        
    from customers
)

select * from customers_with_datetime_fields
