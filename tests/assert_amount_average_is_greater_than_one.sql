{{ config(store_failures = true) }}

select
    customer_id, 
    avg(total_amount_paid) as average_amount
from {{ ref('stg_paid_customer_orders') }}
group by 1
having count(customer_id) > 1 and average_amount < 1