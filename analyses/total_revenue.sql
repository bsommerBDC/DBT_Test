

select
    sum(total_amount_paid) as revenue,
    count(*) as orders_with_payment_count
from {{ ref('stg_successful_payments') }}