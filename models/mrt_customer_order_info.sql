    {{
        config(
            materialized='table'
        )
    }}

select
p.*,
ROW_NUMBER() OVER (ORDER BY p.order_id) as transaction_seq,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY p.order_id) as customer_sales_seq,
CASE 
    WHEN c.first_order_date = p.order_placed_at THEN 'new'
    ELSE 'return' 
END as nvsr,
x.clv_bad as customer_lifetime_value,
c.first_order_date as fdos
FROM {{ ref('stg_paid_customer_orders') }}  p
left join {{ ref('stg_current_customer_order_info') }} as c USING (customer_id)
LEFT OUTER JOIN {{ ref('stg_order_grain_PIT_CLV') }} x on x.order_id = p.order_id
ORDER BY order_id
