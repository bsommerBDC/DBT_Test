    {{
        config(
            materialized='table'
        )
    }}
    
select 
    ORDERID as order_id, 
    max(CREATED) as payment_finalized_date, 
    sum(AMOUNT) / 100.0 as total_amount_paid
from {{ source('stripe', 'payment') }}
where STATUS <> 'fail'
group by 1