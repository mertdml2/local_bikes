{{ config(
    materialized = 'table',
    tags = ['mart', 'inventory', 'flop']
) }}

select
    s.jour,
    s.store_id,
    ds.store_name,

    s.product_id,
    dp.product_name,

    s.total_stock,
    s.total_sold,
    s.couverture,
    s.rank_flop

from {{ ref('int_stock_magasin_top_flop') }} s

join {{ ref('mart__dim_products') }} dp
  on s.product_id = dp.product_id

join {{ ref('mart__dim_stores') }} ds
  on s.store_id = ds.store_id

where s.rank_flop <= 10
