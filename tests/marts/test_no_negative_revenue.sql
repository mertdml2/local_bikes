select *
from {{ ref('mart__fct_ventes') }}
where net_revenue < 0
