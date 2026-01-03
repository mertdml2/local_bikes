{{ config(
    materialized = 'view',
    tags = ['staging', 'categories','ci']
) }}

with source as (

    select
        category_id,
        category_name
    from {{ source('stg', 'categories') }}

),

renamed as (

    select
        cast(category_id as string)     as category_id,
        cast(category_name as string)   as category_name
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['category_id']) }} as category_sk,
        category_id,
        category_name
    from renamed

)

select
    category_sk,
    category_id,
    category_name
from final
