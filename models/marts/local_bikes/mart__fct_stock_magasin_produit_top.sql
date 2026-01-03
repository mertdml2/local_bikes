{{ config(
    materialized = 'table',
    tags = ['mart', 'inventory', 'top']
) }}

select 
s.jour,
s.store_id,
s.product_id,

ss.store_name,
p.product_name,

s.total_stock,
s.total_sold,
s.couverture,
s.rank_best

 from {{ref('int_stock_magasin_top_flop')}} s
 join {{ref('mart__dim_products')}} p on s.product_id = p.product_id
 join {{ref('mart__dim_stores')}} ss on s.store_id = ss.store_id
 
where rank_best <= 10