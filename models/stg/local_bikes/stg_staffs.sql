with source as (

    select *
    from {{ source('stg', 'staffs') }}

),

renamed as (

    select
        cast(staff_id as string) as staff_id,
        cast(store_id as string) as store_id,
        first_name,
        last_name,
        email,
        phone,
        active,
        case when manager_id = 'NULL' then null else cast(manager_id as string) end as manager_id
    from source

)

select *
from renamed