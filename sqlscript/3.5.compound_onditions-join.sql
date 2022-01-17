-- Compound Join Conditions
USE sql_store;
-- 在order_items表中，order_id 和 product_id 共同确定一条数据
SELECT * 
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_Id AND oi.product_id = oin.product_id;
