{{ config(
    materialized = 'table',
    tags = ['mart', 'dimension', 'staff']
) }}

select
    staff_sk,
    store_id,
    first_name,
    last_name,
    is_active,
    manager_id
from {{ ref('stg_staffs') }}
