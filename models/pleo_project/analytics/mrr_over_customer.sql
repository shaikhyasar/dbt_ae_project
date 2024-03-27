select
    customer_id,
    cast(format_date("%Y-%m", date) as string) as date,
    round(sum(amount), 2) as amount
from {{ ref("mrr_analysis") }}
where type = 'subscription'
group by 1, 2