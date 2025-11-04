{% set order_status = ['Shipped', 'Delivered', 'Pending'] %}

with filing_orders as (
    select order_id, DATE_TRUNC('month', order_date) as order_month, order_status
    from {{ ref('orders') }}
),
final_orders as (
    select order_month, 
    COUNT(order_id) as total_orders,
    {% for status in order_status %}
         COUNT(
            CASE WHEN order_status = '{{status}}' THEN 1 ELSE NULL END
            ) as {{status}}_count {% if not loop.last %},{% endif %}
    {% endfor %}

    
    from filing_orders
    group by order_month
    order by order_month
)
select * from final_orders