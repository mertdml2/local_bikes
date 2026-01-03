{{ config(
    materialized = 'table',
    tags = ['mart', 'dimension', 'store']
) }}

select
    store_sk,
    store_id,
    store_name,
    city,
    state
from {{ ref('stg_stores') }}
