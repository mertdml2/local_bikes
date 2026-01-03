{{ config(
    materialized = 'table',
    tags = ['mart', 'customer', 'lifetime']
) }}

with customer_orders as (

    -- Aggregate revenue at order level per customer
    select
        customer_id,
        order_sk,
        order_date,
        sum(net_revenue) as order_revenue
    from {{ ref('int_order_items_detailed') }}
    group by
        customer_id,
        order_sk,
        order_date

),

customer_metrics as (

    select
        customer_id,

        count(distinct order_sk)            as total_orders,
        sum(order_revenue)                  as lifetime_revenue,
        avg(order_revenue)                  as avg_basket,

        min(order_date)                     as first_order_date,
        max(order_date)                     as last_order_date,
        date_diff(
            max(order_date),
            min(order_date),
            day
        )                                   as customer_lifetime_days,

        case
            when count(distinct order_sk) = 1 then 'One-time'
            else 'Repeat'
        end                                 as customer_type

    from customer_orders
    group by customer_id
)

select
    c.customer_id,

    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.zip_code,

    m.total_orders,
    m.lifetime_revenue,
    m.avg_basket,
    m.first_order_date,
    m.last_order_date,
    m.customer_lifetime_days,
    m.customer_type

from customer_metrics m
left join {{ ref('stg_customers') }} c
    on m.customer_id = c.customer_id
