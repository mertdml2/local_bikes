{{ config(
    materialized = 'table',
    tags = ['mart', 'dimension', 'product']
) }}

with products as (

    select
        product_sk,
        product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price
    from {{ ref('stg_products') }}

),

brands as (

    select
        brand_id,
        brand_sk,
        brand_name
    from {{ ref('stg_brands') }}

),

categories as (

    select
        category_id,
        category_sk,
        category_name
    from {{ ref('stg_categories') }}

)

select
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price

from products p
left join brands b
    on p.brand_id = b.brand_id
left join categories c
    on p.category_id = c.category_id
