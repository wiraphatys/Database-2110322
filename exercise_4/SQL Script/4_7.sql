SELECT p.product_id , p.product_description
FROM product AS p
JOIN order_line AS o ON p.product_id = o.product_id
GROUP BY p.product_id
ORDER BY SUM(o.ordered_quantity) DESC
LIMIT 1;