select
    p.product_id,
    p.product_name,
    p.category_name,
    s.order_date,
    sum(s.quantity) as units_sold,
    sum(s.net_revenue) as product_revenue,
    count(distinct s.order_id) as total_orders
from {{ ref('int_order_items_detailed') }} s
join {{ ref('mart__dim_products') }}  p
  on s.product_id = p.product_id
group by
    p.product_id,
    s.order_date,
    p.product_name,
    p.category_name

