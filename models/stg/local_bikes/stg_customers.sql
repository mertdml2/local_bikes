{{ config(
    materialized = 'view',
    tags = ['staging', 'customers']
) }}

with source as (

    select
        customer_id,
        first_name,
        last_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    from {{ source('stg', 'customers') }}

),

renamed as (

    select
        cast(customer_id as string)          as customer_id,
        cast(first_name as string)           as first_name,
        cast(last_name as string)            as last_name,
        cast(phone as string)                as phone,
        cast(email as string)                as email,
        cast(street as string)               as street,
        cast(city as string)                 as city,
        cast(state as string)                as state,
        cast(zip_code as string)             as zip_code
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk,
        customer_id,
        first_name,
        last_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    from renamed

)

select
    customer_sk,
    customer_id,
    first_name,
    last_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
from final
