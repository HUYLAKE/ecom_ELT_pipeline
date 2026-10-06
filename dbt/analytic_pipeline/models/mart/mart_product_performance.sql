SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.supplier,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COALESCE(
        SUM(o.quantity),
        0
    ) AS total_quantity_sold,

    COALESCE(
        SUM(
            CASE
                WHEN o.order_status = 'completed'
                THEN o.total_amount
                ELSE 0
            END
        ),
        0
    ) AS total_revenue,

    COUNT(DISTINCT r.review_id) AS total_reviews,

    ROUND(
        COALESCE(AVG(r.rating), 0),
        2
    ) AS average_rating

FROM {{ ref('dim_products') }} AS p

LEFT JOIN {{ ref('fact_orders') }} AS o
    ON p.product_id = o.product_id

LEFT JOIN {{ ref('stg_reviews') }} AS r
    ON p.product_id = r.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    p.supplier