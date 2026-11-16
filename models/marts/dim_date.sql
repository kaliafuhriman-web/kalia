with date_bounds as (

    select
        min(order_date) as min_date,
        max(order_date) as max_date
    from {{ ref('stg_jaffle_shop__raw_orders') }}

),

date_spine as (

    select date_day
    from date_bounds,
    unnest(generate_date_array(min_date, max_date)) as date_day

)

select
    cast(format_date('%Y%m%d', date_day) as int64) as date_key,
    date_day,
    extract(dayofweek from date_day) as day_of_week,
    format_date('%A', date_day) as day_name,
    extract(day from date_day) as day_of_month,
    extract(dayofyear from date_day) as day_of_year,
    extract(isoweek from date_day) as week_of_year,
    extract(month from date_day) as month_number,
    format_date('%B', date_day) as month_name,
    extract(quarter from date_day) as quarter_number,
    extract(year from date_day) as year_number,
    date_trunc(date_day, month) as first_day_of_month,
    last_day(date_day, month) as last_day_of_month,
    date_trunc(date_day, quarter) as first_day_of_quarter,
    date_trunc(date_day, year) as first_day_of_year,
    extract(dayofweek from date_day) in (1, 7) as is_weekend
from date_spine
