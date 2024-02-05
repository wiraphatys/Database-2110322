DELETE FROM order_line WHERE order_id IN (SELECT order_id FROM order WHERE customer_id = 10001);
DELETE FROM order WHERE customer_id = 10001;
DELETE FROM customer WHERE customer_id = 10001;

SELECT * FROM customer;
SELECT * FROM order;
SELECT * FROM order_line;
