with source as (

    select *
    from {{ source('stg', 'products') }}

),

renamed as (

    select
        cast(product_id as string) as product_id,
        cast(brand_id as string) as brand_id,
        cast(category_id as string) as category_id,
        cast(model_year as string) as model_year,
        /*  put a model_year year condition here */
        cast(list_price as numeric) as list_price,
        product_name
    from source

)

select *
from renamed