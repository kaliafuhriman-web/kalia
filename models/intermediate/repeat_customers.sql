SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.customer_id) AS order_frequency
FROM {{ ref('stg_jaffle_shop__raw_customers') }} c
LEFT JOIN {{ ref('stg_jaffle_shop__raw_orders') }} o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING order_frequency > 1