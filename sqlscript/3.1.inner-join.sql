-- INNER JOIN
-- 查询订单表和用户表，获取所有信息，两张表通过共有的customer_id连接在一起
-- 查询结果只包含在两张表中均可以匹配到的customer_id的结果，匹配不到的都不会返回
SELECT * 
FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;

-- 为要连接的两张表取个别名
SELECT 
	o.customer_id, 
	c.first_name, 
	c.last_name 
FROM orders o      -- orders 用 o 表示
JOIN customers c   -- customers 用 c 表示
	ON o.customer_id = c.customer_id;


-- Exercise
-- order items 表里有 订单id,产品id，数量和单
-- 写一条查询，连接order items和products表
-- Return 
-- 	product id, product name, quantity,unit price
SELECT 
	oi.order_id,
	oi.product_id,
	p.name,
    oi.quantity,
    oi.unit_price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
