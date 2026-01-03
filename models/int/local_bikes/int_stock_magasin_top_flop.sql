{{ config(
    materialized = 'view',
    tags = ['intermediate', 'inventory']
) }}

with base as (

    select
        snapshot_date,
        store_id,
        product_id,
        stock_quantity,
        sold_quantity
    from {{ ref('int_stock_vs_sales') }}

),

agg as (

    select
        snapshot_date                              as jour,
        store_id,
        product_id,
        sum(stock_quantity)                       as total_stock,
        sum(sold_quantity)                        as total_sold,
        {{ calculate_stock_coverage(
            'sum(stock_quantity)',
            'sum(sold_quantity)'
        ) }}                                      as couverture
    from base
    group by
        snapshot_date,
        store_id,
        product_id
),

rank_best as (

    select
        jour,
        store_id,
        product_id,
        row_number() over (
            partition by store_id
            order by couverture desc nulls last
        ) as rank_best
    from agg
),

rank_flop as (

    select
        jour,
        store_id,
        product_id,
        row_number() over (
            partition by store_id
            order by couverture asc
        ) as rank_flop
    from agg
    where couverture > 0
)

select
    a.jour,
    a.store_id,
    a.product_id,
    a.total_stock,
    a.total_sold,
    a.couverture,
    b.rank_best,
    f.rank_flop
from agg a
left join rank_best b
    on  a.jour = b.jour
    and a.store_id = b.store_id
    and a.product_id = b.product_id
left join rank_flop f
    on  a.jour = f.jour
    and a.store_id = f.store_id
    and a.product_id = f.product_id
