{{ config(
    materialized = 'table',
    tags = ['mart', 'sales']
) }}

select
    oi.order_sk,
    o.order_id,
    oi.product_id,
    oi.customer_id,
    oi.store_id,
    oi.staff_id,
    oi.order_date,

    oi.quantity,
    oi.net_revenue

from {{ ref('int_order_items_detailed') }} oi

join {{ ref('stg_orders')}} o 
on o.order_sk = oi.order_sk