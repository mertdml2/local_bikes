with source as (

    select *
    from {{ ref('stg_customers') }}

),

renamed as (

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

    from source

)

select *
from renamed