with source as (

    select *
    from {{ source('stg', 'order_items') }}

),

renamed as (

    select

        {{ dbt_utils.generate_surrogate_key([
        'order_id',
        'item_id'
    ]) }} as order_item_sk,

        cast(order_id as string) as order_id,
        cast(item_id as string) as item_id,
        cast(product_id as string) as product_id,
        quantity,
        list_price,
        discount
    from source

)

select *
from renamed