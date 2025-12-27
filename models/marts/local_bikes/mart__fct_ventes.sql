select
    order_id,
    product_id,
    customer_id,
    store_id,
    staff_id,
    order_date,
    quantity,
    net_revenue
from {{ ref('int_order_items_detailed') }}
