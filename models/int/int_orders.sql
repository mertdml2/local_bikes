with source as (

    select *
    from {{ ref('stg_orders') }}

),

renamed as (

    select
        order_id,
        customer_id,
        store_id,
        staff_id,
        order_status,
        order_date,
        required_date,
        shipped_date
    from source

)

select *
from renamed