with source as (

    select *
    from {{ ref('stg_staffs') }}

),

renamed as (

    select
        staff_id,
        store_id,
        first_name,
        last_name,
        email,
        phone,
        active,
        manager_id
    from source

)

select *
from renamed