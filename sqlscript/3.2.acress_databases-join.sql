-- 选定当前使用的数据库
USE sql_store;
-- 跨越数据库查询
-- 将当前数据库中的order_items表和 sql_inventory数据库中的products表连接起来，进行查询
SELECT 
	oi.order_id,
	oi.product_id,
	p.name,
    oi.quantity,
    oi.unit_price
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;
    
-- 等价于
SELECT 
	oi.order_id,
	oi.product_id,
	p.name,
    oi.quantity,
    oi.unit_price
FROM sql_store.order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;