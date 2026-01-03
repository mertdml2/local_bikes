{{ config(
    materialized = 'view',
    tags = ['staging', 'orders','ci']
) }}

with source as (

    select
        order_id,
        customer_id,
        store_id,
        staff_id,
        order_status,
        order_date,
        required_date,
        shipped_date
    from {{ source('stg', 'orders') }}

),

renamed as (

    select
        cast(order_id as string)        as order_id,
        cast(customer_id as string)     as customer_id,
        cast(store_id as string)        as store_id,
        cast(staff_id as string)        as staff_id,
        cast(order_status as int64)     as order_status,
        cast(order_date as date)        as order_date,
        cast(required_date as date)     as required_date,
        cast(nullif(shipped_date, 'NULL') as date) as shipped_date
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_sk,
        order_id,
        customer_id,
        store_id,
        staff_id,
        order_status,
        order_date,
        required_date,
        shipped_date
    from renamed

)

select
    order_sk,
    order_id,
    customer_id,
    store_id,
    staff_id,
    order_status,
    order_date,
    required_date,
    shipped_date
from final
