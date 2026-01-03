{{ config(
    materialized = 'view',
    tags = ['staging', 'order_items','ci']
) }}

with source as (

    select
        order_id,
        item_id,
        product_id,
        quantity,
        list_price,
        discount
    from {{ source('stg', 'order_items') }}

),

renamed as (

    select
        cast(order_id as string)        as order_id,
        cast(item_id as string)         as item_id,
        cast(product_id as string)      as product_id,
        cast(quantity as integer)       as quantity,
        cast(list_price as numeric)     as list_price,
        cast(discount as numeric)       as discount
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key([
            'order_id',
            'item_id'
        ]) }} as order_item_sk,
        order_id,
        item_id,
        product_id,
        quantity,
        list_price,
        discount
    from renamed

)

select
    order_item_sk,
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
from final
