with customer_orders as (
    select
        customer_id,
        order_id,
        order_date,
        sum(net_revenue) as order_revenue
    from {{ ref('int_order_items_detailed') }}
    group by customer_id, order_id, order_date
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,

    count(distinct co.order_id) as total_orders,
    sum(co.order_revenue) as lifetime_revenue,
    avg(co.order_revenue) as avg_basket,

    min(co.order_date) as first_order_date,
    max(co.order_date) as last_order_date,
    date_diff(max(co.order_date), min(co.order_date), day) as customer_lifetime_days,
    case
        when count(distinct co.order_id) = 1 then 'One-time'
        else 'Repeat'
    end as customer_type


from customer_orders co
join {{ ref('mart__dim_customers') }} c
  on co.customer_id = c.customer_id
group by
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state
