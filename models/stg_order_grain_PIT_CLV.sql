    {{
        config(
            materialized='table'
        )
    }}

select
        p.order_id,
        sum(t2.total_amount_paid) as clv_bad
from {{ ref('stg_paid_customer_orders') }} p
left join {{ ref('stg_paid_customer_orders') }} t2 on p.customer_id = t2.customer_id and p.order_id >= t2.order_id
group by 1
order by p.order_id