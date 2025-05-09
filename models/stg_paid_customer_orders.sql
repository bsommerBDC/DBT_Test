{{ config(materialized="table") }}


select
    orders.id as order_id,
    orders.user_id as customer_id,
    orders.order_date as order_placed_at,
    orders.status as order_status,
    payments.total_amount_paid,
    payments.payment_finalized_date,
    customers.first_name as customer_first_name,
    customers.last_name as customer_last_name
from {{ source("jaffle_shop", "orders") }} as orders
left join {{ ref("stg_successful_payments") }} payments on orders.id = p.order_id
left join {{ source("jaffle_shop", "customers") }} customers on orders.user_id = c.id
