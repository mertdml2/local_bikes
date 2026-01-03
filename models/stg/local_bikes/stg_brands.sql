{{ config(
    materialized = 'view',
    tags = ['staging', 'brands']
) }}

with source as (

    select
        brand_id,
        brand_name
    from {{ source('stg', 'brands') }}

),

renamed as (

    select
        cast(brand_id as string)      as brand_id,
        cast(brand_name as string)    as brand_name
    from source

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['brand_id']) }} as brand_sk,
        brand_id,
        brand_name
    from renamed

)

select
    brand_sk,
    brand_id,
    brand_name
from final
