SELECT
    customer_id,
    full_name,
    email,
    phone,
    address,
    city,
    created_at
FROM {{ ref('stg_customers') }}