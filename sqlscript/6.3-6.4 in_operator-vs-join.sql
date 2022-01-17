-- Find the products that have never been ordered
USE sql_store;
-- Solution 1
SELECT 
	p.product_id,
    p.name
FROM products p
LEFT JOIN order_items oi
	USING(product_id)
WHERE order_id IS NULL;

-- Solution 2 使用子查询
SELECT 
	product_id,
    name
FROM products 
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM order_items
);


-- Exercise 6.3
-- Find clients without invoices
USE sql_invoicing;
-- Solution 1  联表查询
SELECT 
	c.client_id, 
    c.name
FROM clients c
LEFT JOIN invoices i USING (client_id)
WHERE invoice_id IS NULL;

-- Solution 1  子查询
SELECT 
	client_id, 
    name
FROM clients 
WHERE client_id NOT IN (
	SELECT DISTINCT client_id
	FROM invoices 
);


-- Exercise 6.4
-- Find customers who have ordered lettuce (id = 3)
-- 		Select customer_id, first_name, last_name
USE sql_store;
-- Solution 1 子连接 （3层查询）
SELECT 
	customer_id, 
	first_name, 
	last_name
FROM customers
WHERE customer_id IN (
	SELECT customer_id
    FROM orders
    WHERE order_id IN (
    	SELECT order_id 
		FROM order_items
		WHERE product_id = 3
    )
);

-- Solution 2 联表查询
SELECT DISTINCT
	c.customer_id, 
	c.first_name, 
	c.last_name
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3;
