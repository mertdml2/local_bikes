{{ config(
    materialized = 'view',
    tags = ['staging', 'stores']
) }}

with source as (

    select
        store_id,
        store_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    from {{ source('stg', 'stores') }}

),

renamed as (

    select
        cast(store_id as string)      as store_id,
        cast(store_name as string)    as store_name,
        cast(phone as string)         as phone,
        cast(email as string)         as email,
        cast(street as string)        as street,
        cast(city as string)          as city,
        cast(state as string)         as state,
        cast(zip_code as string)      as zip_code
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['store_id']) }} as store_sk,
        store_id,
        store_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    from renamed

)

select
    store_sk,
    store_id,
    store_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
from final
