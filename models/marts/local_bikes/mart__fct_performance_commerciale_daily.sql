{{ config(
    materialized = 'table',
    tags = ['mart', 'fact', 'sales']
) }}

select
    d.order_date,

    sum(d.net_revenue) as total_revenue,
    count(distinct d.order_sk) as total_orders,
    sum(d.quantity) as total_units,
    safe_divide(
        sum(d.net_revenue),
        count(distinct d.order_sk)
    ) as avg_basket

from {{ ref('int_order_items_detailed') }} d

group by
    d.order_date
