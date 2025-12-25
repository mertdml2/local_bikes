with source as (

    select *
    from {{ source('stg', 'brands') }}

),

renamed as (

    select
        cast(brand_id as string)  as brand_id,
        cast(brand_name as string)  as brand_name
    from source

)

select *
from renamed