with source as (

    select *
    from {{ source('stg', 'stores') }}

),

renamed as (

    select
        cast(store_id as string) as store_id,
        store_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    from source

)

select *
from renamed