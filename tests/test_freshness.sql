-- This test is used to ensure how fresh is our data
-- Assumptions: Today, If our model is running, then yesterday record is received.
-- If this model test lastest record data is from yesterday, then we are good to go
-- Otherwise, day before yesterday is our lasted record, then we didn't recieve new
-- record yet, so we return error
-- setting severity to warn

{{ config(severity = 'warn') }}
{% set yesterday = modules.datetime.date.today() - modules.datetime.timedelta(days=1) %}
with
    lastest_record as (
        select max(period_start) as max_date from {{ ref("invoice_item") }}
    )

select *
from lastest_record
where max_date <> '{{ yesterday.strftime("%Y-%m-%d") }}'
