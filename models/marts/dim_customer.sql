SELECT
    c.customer_id,
    c.customer_name,
    (
        SELECT COUNT(DISTINCT o.order_id)
        FROM {{ ref('stg_jaffle_shop__raw_orders') }} AS o
        WHERE o.customer_id = c.customer_id
    ) AS order_count,
    (
        SELECT COUNT(DISTINCT o.order_id)
        FROM {{ ref('stg_jaffle_shop__raw_orders') }} AS o
        WHERE o.customer_id = c.customer_id
    ) > 1 AS is_repeat

FROM {{ ref('stg_jaffle_shop__raw_customers') }} AS c