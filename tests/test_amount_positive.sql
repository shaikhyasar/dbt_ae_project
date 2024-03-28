-- this test will failed, because there may be transactions of refund, cashback,
-- cancellation
-- This test will give any refund, cashback, cancellation on yesterday.
-- This will provide seperate table of negative data which will helpful for furthur
-- analysis
-- This test will return warning if amount is less than zero

{{ config(severity = 'warn') }}
{% set yesterday = modules.datetime.date.today() - modules.datetime.timedelta(days=1) %}

with
    yesterday_transactions as (
        select customer_id, type, date, amount
        from {{ ref("mrr_analysis") }}
        where date(date) = '{{ yesterday.strftime("%Y-%m-%d") }}'
    )

select customer_id, type, date, amount
from yesterday_transactions
where amount < 0
