
{% set old_etl_relation=ref('legacy__customer_orders')%}
{% set dbt_relation=ref('mrt_customer_order_info')%}

{{ audit_helper.compare_relations(
    a_relation=old_etl_relation,
    b_relation=dbt_relation,
    primary_key="order_id"
)}}