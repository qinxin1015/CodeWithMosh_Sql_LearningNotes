-- USING 子句
-- 下面是一个联表查询
SELECT 
	o.order_id,
    c.first_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
-- 当联表查询时的连接字段名相同，则可以用更简洁的USING子句替换ON子句
-- USING 改写如下:
SELECT 
	o.order_id,
    c.first_name
FROM orders o
JOIN customers c
	USING (customer_id);
    
-- INNER JOIN 和 OUTER JOIN 都可以使用 USING子句
-- 但是，如果两个表中用于关联的字段名不一致，则只能使用 ON子句
SELECT 
	o.order_id,
    c.first_name,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id)
LEFT JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- 通过复合主键连接查询
SELECT 
	oi.order_Id, 
    oi.product_id,
    oin.note
FROM order_items oi
LEFT JOIN order_item_notes oin
	USING (order_id, product_id);
-- 等价于
SELECT 
	oi.order_Id, 
    oi.product_id,
    oin.note
FROM order_items oi
LEFT JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;
    

-- Exercise
-- sql invoicing database
-- from payment,clients,payment_methods table Return
-- 		date (payment)
-- 		client (clients)
-- 		amount (payment)
-- 		name (payment_methods) 付款方式
SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS 'payment methods'
FROM payments p
LEFT JOIN clients c
	USING (client_id)
LEFT JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

    