with source as (

    select *
    from {{ ref('stg_order_items') }}

),

renamed as (

    select
        order_id,
        item_id,
        product_id,
        quantity,
        list_price,
        discount
    from source

)

select *
from renamed