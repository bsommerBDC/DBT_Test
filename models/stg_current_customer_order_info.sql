{{ config(materialized="table") }}

select
    customers.id as customer_id,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date,
    count(orders.id) as number_of_orders,
from {{ source("jaffle_shop", "customers") }} customers
left join {{ source("jaffle_shop", "orders") }} as orders on orders.user_id = c.id
group by 1
