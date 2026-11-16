select
    customer_id,
    customer_name,
    sku,
    product_name,
    order_count,
    item_count,
    last_ordered_at
from {{ ref('int_customer_products') }}
where frequency_rank = 1
