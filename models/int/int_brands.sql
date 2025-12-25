with brands as (

    select *
    from {{ ref('stg_brands') }}

),

final as (

    select
        brand_id,
        brand_name,
        upper(brand_name) as brand_name_upper
    from brands

)

select *
from final
