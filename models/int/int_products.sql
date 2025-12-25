with source as (

    select *
    from {{ ref('stg_products') }}

),

renamed as (

    select
     product_id, 
     brand_id,
     category_id,
     model_year,
     list_price,
     product_name
    from source

)

select *
from renamed