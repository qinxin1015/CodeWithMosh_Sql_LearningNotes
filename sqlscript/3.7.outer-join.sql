USE sql_store;
-- INNER JOIN 只会筛选出在两个表中的customer_id均存在的数据
SELECT 
	c.customer_id,
	c.first_name,
	o.order_id
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- LEFT JOIN 会筛选出customers表中所有的数据，尽管有的数据没有订单order_id
SELECT 
	c.customer_id,
	c.first_name,
	o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- RIGHT JOIN 会筛选出orders表中所有的数据,无论其在customers中是否能匹配到
SELECT 
	c.customer_id,
	c.first_name,
	o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


-- Exercise
-- 从产品表和订单商品表查询产品ID，产品名称和被订购的数量（有些产品从未被订购过）
-- Return
-- 		product id, name, quantity
SELECT 
	p.product_id,
	p.name,
	oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id;