{{ config(
    materialized = 'view',
    tags = ['intermediate', 'orders']
) }}

with order_items as (

    select
        order_item_sk,
        order_id,
        product_id,
        quantity,
        list_price,
        discount
    from {{ ref('stg_order_items') }}

),

orders as (

    select
        order_sk,
        order_id,
        customer_id,
        store_id,
        staff_id,
        order_date
    from {{ ref('stg_orders') }}

),

enriched as (

    select
        oi.order_item_sk,
        o.order_sk,
        oi.product_id,
        o.customer_id,
        o.store_id,
        o.staff_id,
        o.order_date,
        oi.quantity,
        oi.list_price,
        oi.discount,
        {{ calculate_net_revenue(
            'oi.quantity',
            'oi.list_price',
            'oi.discount'
        ) }} as net_revenue
    from order_items oi
    left join orders o
        on oi.order_id = o.order_id
)

select
    order_item_sk,
    order_sk,
    product_id,
    customer_id,
    store_id,
    staff_id,
    order_date,
    quantity,
    list_price,
    discount,
    net_revenue
from enriched
