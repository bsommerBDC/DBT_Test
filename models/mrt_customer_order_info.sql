{{ config(materialized="table") }}

select
    paid_orders.*,
    row_number() over (order by paid_orders.order_id) as transaction_seq,
    row_number() over (partition by paid_orders.customer_id order by paid_orders.order_id) as customer_sales_seq,
    case
        when customer_order_info.first_order_date = paid_orders.order_placed_at then 'new' else 'return'
    end as nvsr,
    clv.clv_bad as customer_lifetime_value,
    customer_order_info.first_order_date as fdos
from {{ ref("stg_paid_customer_orders") }} paid_orders
left join {{ ref("stg_current_customer_order_info") }} as customer_order_info using (customer_id)
left outer join {{ ref("stg_order_grain_PIT_CLV") }} clv on using (order_id)
order by order_id
