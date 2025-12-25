with source as (

    select *
    from {{ source('stg', 'orders') }}

),

renamed as (

    select
        cast(order_id as string) as order_id,
        cast(customer_id as string) as customer_id,
        cast(store_id as string) as store_id,
        cast(staff_id as string) as staff_id,
        order_status,
        cast(order_date as date) as order_date,
        cast(required_date as date) as required_date,
        case when shipped_date = 'NULL' then null else cast(shipped_date as date) end as shipped_date
    from source

)

select *
from renamed