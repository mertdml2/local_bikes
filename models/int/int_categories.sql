with categories as (

    select *
    from {{ ref('stg_categories') }}

),

final as (

    select
        category_id,
        category_name
    from categories

)

select *
from final
