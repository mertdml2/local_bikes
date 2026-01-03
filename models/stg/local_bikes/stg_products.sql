{{ config(
    materialized = 'view',
    tags = ['staging', 'products']
) }}

with source as (

    select
        product_id,
        brand_id,
        category_id,
        model_year,
        list_price,
        product_name
    from {{ source('stg', 'products') }}

),

renamed as (

    select
        cast(product_id as string)        as product_id,
        cast(brand_id as string)          as brand_id,
        cast(category_id as string)       as category_id,
        cast(model_year as int64)          as model_year,
        cast(list_price as numeric)       as list_price,
        cast(product_name as string)      as product_name
    from source
    -- row-level data quality rules belong in staging
    where cast(model_year as int64) >= 2000
),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk,
        product_id,
        brand_id,
        category_id,
        model_year,
        list_price,
        product_name
    from renamed

)

select
    product_sk,
    product_id,
    brand_id,
    category_id,
    model_year,
    list_price,
    product_name
from final
