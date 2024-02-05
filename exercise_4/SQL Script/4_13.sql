SELECT SUM(p.standard_price * ol.ordered_quantity) AS total_payment FROM ordert o
JOIN order_line ol ON o.order_id = ol.order_id
JOIN product p ON p.product_id = ol.product_id
WHERE o.order_id = 3;