-- exists 关键字
-- Select clients that have an invoice
-- Solution 1 where 子查询
SELECT client_id
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id
    FROM invoices
);

-- Solution 2: 内连接
SELECT DISTINCT c.client_id
FROM clients c
JOIN invoices i USING (client_id);

-- Solution 3: EXISTS 关键字
SELECT client_id
FROM clients c
WHERE EXISTS (
	SELECT DISTINCT client_id
    FROM invoices
    WHERE client_id = c.client_id
);


-- Exercise
-- Find the products that have never been ordered
USE sql_store;
-- Solution 1 where 子查询
SELECT product_id, name
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
    FROM order_items
);
-- Solution 2: EXISTS 关键字
SELECT product_id, name
FROM products p
WHERE NOT EXISTS (
	SELECT DISTINCT product_id
    FROM order_items
    WHERE product_id = p.product_id
);



