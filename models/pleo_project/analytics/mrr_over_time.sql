select
    date,
    extract(isoweek from date) as week,
    extract(month from date) as month,
    extract(quarter from date) as quarter,
    extract(year from date) as year,
    round(sum(amount), 2) as amount
from {{ ref("mrr_analysis") }}
where type = 'subscription'
group by date