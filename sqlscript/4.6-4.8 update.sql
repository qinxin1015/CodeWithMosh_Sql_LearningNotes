-- INSERT ONE ROW
UPDATE invoices
SET payment_total = 0, payment_date = NULL
WHERE invoice_id = 1;

UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE invoice_id = 3;

-- INSERT Multi-ROWs
-- 更新所有client_id = 3的客户的信息
UPDATE invoices
SET 
	payment_total = invoice_total * 0.75, 
	payment_date = due_date
WHERE client_id = 3;
-- 5 row(s) affected, 5 warning(s): 
-- 1265 Data truncated for column 'payment_total' at row 1 1265 Data truncated for column 'payment_total' 
-- at row 2 1265 Data truncated for column 'payment_total' at row 3 1265 Data truncated for column 'payment_total' 
-- at row 4 1265 Data truncated for column 'payment_total' at row 5 Rows matched: 5  Changed: 5  Warnings: 5	0.094 sec

-- 也可以使用IN关键字，更新所有client_id = 3 和 4的客户的信息
UPDATE invoices
SET 
	payment_total = invoice_total * 0.8, 
	payment_date = due_date
WHERE client_id IN (3,4);


-- Exercise
-- Write a SQL statement to
-- 		give any customers born before 1990
-- 		50 extra points
-- 1.select: birth_date < '1990-01-01'
SELECT points + 50
FROM customers
WHERE birth_date < '1990-01-01';
-- 2. update: points = points + 50
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';
-- 11:55:54	UPDATE customers SET points = points + 50 WHERE birth_date < '1990-01-01'	
-- 7 row(s) affected Rows matched: 7  Changed: 7  Warnings: 0	0.078 sec


-- UPDATE USING SUBQUERIRS
UPDATE invoices
SET 
	payment_total = invoice_total * 0.88, 
	payment_date = due_date
WHERE client_id =
(SELECT client_id
FROM clients
WHERE name = 'Myworks');

-- Exercise
-- UPDATE orders table
-- 为积分超过3000的顾客更新订单里的注释信息
-- 1. select customer whose points > 3000
SELECT customer_id 
FROM customers
WHERE points > 3000;
-- 2. update comments from orders table
UPDATE orders
SET comments = 'Golden'
WHERE customer_id IN(
	SELECT customer_id 
	FROM customers
	WHERE points > 3000
);
