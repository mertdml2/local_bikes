with source as (

    select *
    from {{ source('stg', 'categories') }}

),

renamed as (

    select
        cast(category_id as string)  as category_id,
        cast(category_name as string)  as category_name
    from source

)

select *
from renamed