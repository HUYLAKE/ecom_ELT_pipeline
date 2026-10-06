SELECT
    product_id,
    product_name,
    category,
    brand,
    supplier,
    unit_price,
    stock_quantity,
    created_at
FROM {{ source('raw', 'products') }}