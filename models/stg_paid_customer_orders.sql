    {{
        config(
            materialized='table'
        )
    }}


select 
    orders.ID as order_id,
    orders.USER_ID	as customer_id,
    orders.ORDER_DATE AS order_placed_at,
    orders.STATUS AS order_status,
    p.total_amount_paid,
    p.payment_finalized_date,
    C.FIRST_NAME    as customer_first_name,
    C.LAST_NAME as customer_last_name
FROM {{ source('jaffle_shop', 'orders') }} as orders
left join {{ ref('stg_successful_payments') }} p ON orders.ID = p.order_id
left join {{ source('jaffle_shop', 'customers') }} C on orders.USER_ID = C.ID