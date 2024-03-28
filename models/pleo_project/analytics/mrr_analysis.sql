with
    mrr_conversion as (
        select
            id,
            customer_id,
            type,
            case
                when diff_date = 0
                then converted_amount
                else round(converted_amount / diff_date, 2)
            end amount,
            date(period_start) as period_start,
            diff_date
        from {{ ref("int_mrr_conversion") }}
    ),
    each_day_record as (
        select
            id,
            customer_id,
            type,
            amount,
            case
                when diff_date = 0
                then period_start
                else
                    date_add(
                        period_start,
                        interval(row_number() over (partition by id order by n) - 1) day
                    )
            end date
        from mrr_conversion
        cross join
            unnest(
                case
                    when diff_date = 0
                    then array[1]
                    else generate_array(1, diff_date, 1)
                end
            ) as n
    )
select customer_id, type, date, round(sum(amount), 2) as amount
from each_day_record
group by 1, 2, 3

-- SELECT * FROM each_day_record
