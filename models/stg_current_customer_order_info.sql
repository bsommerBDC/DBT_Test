    {{
        config(
            materialized='table'
        )
    }}

select 
    C.ID as customer_id,
    min(ORDER_DATE) as first_order_date,
    max(ORDER_DATE) as most_recent_order_date,
    count(ORDERS.ID) AS number_of_orders,
from {{ source('jaffle_shop', 'customers') }} C 
left join {{ source('jaffle_shop', 'orders') }} as Orders
    on orders.USER_ID = C.ID 
group by 1