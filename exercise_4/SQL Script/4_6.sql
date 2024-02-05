SELECT c.customer_id , c.customer_name FROM customer c
JOIN ordert o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY count(*) DESC
LIMIT 1;