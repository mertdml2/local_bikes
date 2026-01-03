{{ config(
    materialized = 'table',
    tags = ['mart', 'fact', 'store']
) }}

select
    s.store_sk,
    s.store_id,
    d.order_date,

    sum(d.net_revenue) as store_revenue,
    count(distinct d.order_sk) as store_orders,
    sum(d.quantity) as units_sold,
    safe_divide(
        sum(d.net_revenue),
        count(distinct d.order_sk)
    ) as avg_basket

from {{ ref('int_order_items_detailed') }} d
join {{ ref('stg_stores') }} s
  on d.store_id = s.store_id

group by
    s.store_sk,
    s.store_id,
    d.order_date
