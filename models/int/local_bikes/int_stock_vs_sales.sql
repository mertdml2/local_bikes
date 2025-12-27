select
    i.snapshot_date,
    i.store_id,
    i.product_id,
    coalesce(sum(i.stock_quantity),0) as stock_quantity,
    coalesce(sum(s.quantity), 0) as sold_quantity
from {{ ref('int_stocks') }} i
left join {{ ref('int_order_items_detailed') }} s
  on i.store_id = s.store_id
 and i.product_id = s.product_id
 and s.order_date <= i.snapshot_date
group by 

    i.snapshot_date,
    i.store_id,
    i.product_id
