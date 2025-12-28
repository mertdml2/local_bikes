select
    s.store_id,
    st.store_name,
    s.order_date,
    sum(s.net_revenue) as store_revenue,
    count(distinct s.order_id) as store_orders,
    sum(s.quantity) as units_sold,
    safe_divide(sum(s.net_revenue), count(distinct s.order_id)) as avg_basket
from {{ ref('int_order_items_detailed') }} s
join {{ ref('mart__dim_stores') }} st
  on s.store_id = st.store_id
group by s.store_id, st.store_name,s.order_date
