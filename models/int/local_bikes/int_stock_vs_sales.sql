{{ config(
    materialized = 'view',
    tags = ['intermediate', 'inventory','ci']
) }}

with stocks as (

    select
        snapshot_date,
        store_id,
        product_id,
        stock_quantity
    from {{ ref('int_stocks') }}

),

sales as (

    select
        store_id,
        product_id,
        order_date,
        quantity
    from {{ ref('int_order_items_detailed') }}

),

aggregated as (

    select
        s.snapshot_date,
        s.store_id,
        s.product_id,

        coalesce(sum(s.stock_quantity), 0) as stock_quantity,
        coalesce(sum(sa.quantity), 0)       as sold_quantity

    from stocks s
    left join sales sa
        on s.store_id = sa.store_id
       and s.product_id = sa.product_id
       and sa.order_date <= s.snapshot_date

    group by
        s.snapshot_date,
        s.store_id,
        s.product_id
)

select *
from aggregated
