{{ config(
    materialized = 'table',
    tags = ['mart', 'dimension', 'customer']
) }}

select
    customer_sk,
    customer_id,
    first_name,
    last_name,
    city,
    state,
    zip_code
from {{ ref('stg_customers') }}
