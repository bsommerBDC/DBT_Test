

select 
    customer_id 
from {{ ref("stg_current_customer_order_info") }} 
group by customer_id 
having count(*) > 1
