SELECT c.customer_id , c.customer_name , count(*) AS number_of_orders FROM customer c
JOIN ordert o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY number_of_orders DESC;