SELECT postal_code, count(*) AS customer_numbers FROM customer
GROUP BY postal_code
ORDER BY customer_numbers DESC;
