{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

SELECT
    order_id,
    customer_id,
    product_id,
    quantity,
    unit_price,
    discount_amount,
    gross_amount,
    total_amount,
    order_status,
    order_date

FROM {{ ref('stg_orders') }}

{% if is_incremental() %}

WHERE order_date > (
    SELECT MAX(order_date)
    FROM {{ this }}
)

{% endif %}