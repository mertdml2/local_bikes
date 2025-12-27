with order_items as (

    select *
    from {{ ref('stg_order_items') }}

),

orders as (

    select *
    from {{ ref('stg_orders') }}

),

enriched as (

    select
        oi.order_id,
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        o.customer_id,
        o.store_id,
        o.staff_id,
        o.order_date,
        oi.quantity * oi.list_price * (1 - oi.discount) as net_revenue

    from order_items oi 
    left join orders o on oi.order_id = o.order_id

)

select *
from enriched