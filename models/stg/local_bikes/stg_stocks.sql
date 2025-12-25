with source as (

    select *
    from {{ source('stg', 'stocks') }}

),

renamed as (

    select
        cast(product_id as string) as product_id,
        cast(store_id as string) as store_id,
        cast(quantity as numeric) as quantity
    from source

)

select *
from renamed