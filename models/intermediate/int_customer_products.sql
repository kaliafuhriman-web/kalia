with customer_products as (
    select
        o.customer_id,
        c.customer_name,
        p.sku,
        p.product_name,
        count(distinct o.order_id) as order_count,
        count(i.item_id) as item_count,
        max(o.ordered_at) as last_ordered_at
    from {{ ref('stg_jaffle_shop__raw_orders') }} as o
    inner join {{ ref('stg_jaffle_shop__raw_items') }} as i
        on o.order_id = i.order_id
    inner join {{ ref('stg_jaffle_shop__raw_products') }} as p
        on i.sku = p.sku
    inner join {{ ref('stg_jaffle_shop__raw_customers') }} as c
        on o.customer_id = c.customer_id
    group by
        o.customer_id,
        c.customer_name,
        p.sku,
        p.product_name
),
ranked_customer_products as (
    select
        *,
        rank() over (
            partition by customer_id
            order by order_count desc
        ) as frequency_rank
    from customer_products
)
select *
from ranked_customer_products