with agg as (
    select
        snapshot_date as jour,
        store_id,
        product_id,
        sum(stock_quantity) as total_stock,
        sum(sold_quantity) as total_sold,
        round(
            sum(sold_quantity) / nullif(sum(stock_quantity), 0),
            2
        ) as couverture
    from {{ ref('int_stock_vs_sales') }}
    group by 
        snapshot_date, 
        store_id,
        product_id
),

rank_best as (
    select
        *,
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
    a.*,
    b.rank_best,
    f.rank_flop
from agg a
left join rank_best b
    using (jour, store_id, product_id)
left join rank_flop f
    using (jour, store_id, product_id)
