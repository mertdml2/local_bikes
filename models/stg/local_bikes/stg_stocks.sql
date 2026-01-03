{{ config(
    materialized = 'view',
    tags = ['staging', 'stocks','ci']
) }}

with source as (

    select
        product_id,
        store_id,
        quantity
    from {{ source('stg', 'stocks') }}

),

renamed as (

    select
        cast(product_id as string)     as product_id,
        cast(store_id as string)       as store_id,
        cast(quantity as int64)        as quantity
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key([
            'product_id',
            'store_id'
        ]) }} as stock_sk,
        product_id,
        store_id,
        quantity
    from renamed

)

select
    stock_sk,
    product_id,
    store_id,
    quantity
from final
