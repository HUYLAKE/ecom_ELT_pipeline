SELECT
    order_id,
    customer_id,
    product_id,
    quantity,
    unit_price,
    discount_amount,

    quantity * unit_price AS gross_amount,

    quantity * unit_price - discount_amount AS total_amount,

    order_status,
    order_date
FROM {{ source('raw', 'orders') }}