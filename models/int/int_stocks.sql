with source as (

    select *
    from {{ref('stg_stocks')}}

),

renamed as (

    select
        product_id,
        store_id,
        quantity
    from source

)

select *
from renamed