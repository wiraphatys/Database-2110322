SELECT DISTINCT c.customer_id , c.customer_name FROM customer c
JOIN ordert o ON c.customer_id = o.customer_id
WHERE order_date BETWEEN '2020-01-10' AND '2020-01-15';