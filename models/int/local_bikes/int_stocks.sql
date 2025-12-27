select
    product_id,
    store_id,
    quantity as stock_quantity,
    current_date() as snapshot_date
from {{ ref('stg_stocks') }}