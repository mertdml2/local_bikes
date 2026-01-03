/* Catches broken joins, empty orders, bad source ingestion */

select
    order_id
from {{ ref('mart__fct_ventes') }}
group by order_id
having sum(quantity) <= 0
