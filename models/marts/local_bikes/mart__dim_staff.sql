select
    staff_id,
    store_id,
    first_name,
    last_name,
    active as is_active,
    manager_id
from {{ ref('stg_staffs') }}
