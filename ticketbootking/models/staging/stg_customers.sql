-- Staging model for customers table
-- This model cleans and standardizes the raw customers data

with source_data as (
    select * from {{ source('ticket_booking', 'customers') }}
),

renamed as (
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
        updated_at
        
    from source_data
)

select * from renamed
