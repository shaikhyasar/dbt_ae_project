with
    source_record as (select * from {{ ref("mrr_over_time") }}),
    daily as (
        select
            cast(date as string) as date,
            "daily" as date_part,
            round(sum(amount), 2) as amount
        from source_record
        group by 1
    ),
    quarterly as (
        select
            concat(cast(year as string), '-Q', cast(quarter as string)) as date,
            "quarterly" as date_part,
            round(sum(amount), 2) as amount
        from source_record
        group by 1
    ),
    yearly as (
        select
            cast(year as string) as date,
            "yearly" as date_part,
            round(sum(amount), 2) as amount
        from source_record
        group by 1
    ),
    monthly as (
        select
            cast(format_date("%Y-%m", date) as string) as date,
            "monthly" as date_part,
            round(sum(amount), 2) as amount
        from source_record
        group by 1
    ),
    weekly as (
        select
            cast(date_trunc(date, week) as string) as date,
            "weekly" as date_part,
            round(sum(amount), 2) as amount
        from source_record
        group by 1
    )
select *
from daily
union all
select *
from quarterly
union all
select *
from yearly
union all
select *
from monthly
union all
select *
from weekly