select
    product_id,
    count(*) as cnt
from {{ ref('mart__dim_products') }}
group by product_id
having count(*) > 1
