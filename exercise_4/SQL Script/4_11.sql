SELECT c.customer_id , c.customer_name FROM customer c
LEFT JOIN ordert o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL
ORDER BY c.customer_id ASC;