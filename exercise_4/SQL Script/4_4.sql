SELECT p.product_id, p.product_description
FROM product AS p
JOIN (
    SELECT product_id, COUNT(*) AS order_count
    FROM order_line
    GROUP BY product_id
) AS o ON p.product_id = o.product_id
WHERE o.order_count = (
    SELECT MAX(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM order_line
        GROUP BY product_id
    ) AS counts
)
ORDER BY p.product_id;
