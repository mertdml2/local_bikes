select
snapshot_date as jour,
store_id,
sum(stock_quantity) as total_stock,
sum(sold_quantity) as total_sold,
round((sum(sold_quantity) / sum(stock_quantity)),2) as couverture
from {{ ref('int_stock_vs_sales') }}
group by 

snapshot_date, 
store_id