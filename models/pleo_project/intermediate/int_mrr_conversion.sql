with
    conversion as (
        select
            *,
            case
                when currency = 'dkk'
                then amount * 7.45
                when currency = 'sek'
                then amount * 11.22
                when currency = 'gdp'
                then amount * 0.87
                else amount
            end as converted_amount,
            datetime_diff(date(period_end), date(period_start), day) as diff_date
        from {{ ref("invoice_item") }}
    ),
    combine_table as (
        select it.*, i.string_field_1 as customer_id
        from conversion it
        join {{ ref("invoice") }} i on i.string_field_0 = it.invoice_id
    )
select *
from combine_table
