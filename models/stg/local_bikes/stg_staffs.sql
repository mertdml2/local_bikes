{{ config(
    materialized = 'view',
    tags = ['staging', 'staffs','ci']
) }}

with source as (

    select
        staff_id,
        store_id,
        first_name,
        last_name,
        email,
        phone,
        active,
        manager_id
    from {{ source('stg', 'staffs') }}

),

renamed as (

    select
        cast(staff_id as string)          as staff_id,
        cast(store_id as string)          as store_id,
        cast(first_name as string)        as first_name,
        cast(last_name as string)         as last_name,
        cast(email as string)             as email,
        cast(phone as string)             as phone,
        cast(active as bool)              as is_active,
        cast(nullif(manager_id, 'NULL') as string) as manager_id
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['staff_id']) }} as staff_sk,
        staff_id,
        store_id,
        manager_id,
        first_name,
        last_name,
        email,
        phone,
        is_active
    from renamed

)

select
    staff_sk,
    staff_id,
    store_id,
    manager_id,
    first_name,
    last_name,
    email,
    phone,
    is_active
from final
