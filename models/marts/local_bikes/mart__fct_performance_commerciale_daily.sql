select
    order_date,
    sum(net_revenue) as total_revenue,
    count(distinct order_id) as total_orders,
    sum(quantity) as total_units,
    safe_divide(sum(net_revenue), count(distinct order_id)) as avg_basket
from {{ ref('int_order_items_detailed') }}
group by order_date
