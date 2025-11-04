WITH filing_orders AS (
    SELECT id as order_id, user_id as customer_id, date as order_date, status as order_status, {{ convertString('address') }} as order_address, {{ convertString('status') }} as order_status_lower, {{ append_to_string('status', "'asdf'") }} as status_appended  FROM {{ source('filing_wh', 'orders') }}
)
select * from filing_orders