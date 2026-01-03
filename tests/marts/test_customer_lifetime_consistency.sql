select *
from {{ ref('mart__customer_summary') }}
where
    last_order_date < first_order_date
    or customer_lifetime_days < 0
