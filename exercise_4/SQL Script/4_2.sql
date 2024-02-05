SELECT postal_code, count(*) AS customer_numbers FROM customer
GROUP BY postal_code
HAVING count(*) > 1
ORDER BY customer_numbers DESC;
