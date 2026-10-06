SELECT
    review_id,
    customer_id,
    product_id,
    rating,
    review_comment,
    review_date
FROM {{ source('raw', 'reviews') }}