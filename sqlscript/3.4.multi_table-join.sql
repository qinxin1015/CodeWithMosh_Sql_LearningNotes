-- 多表连接查询
-- 连接 订单表， 客户表，订单状态表
-- Return
-- 	order id, order date, first name, last name, order state
USE sql_store;

SELECT 
	o.order_id,
	o.order_date,
	c.first_name,
	c.last_name,
	os.name AS state
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
    
-- 连接 支付表， 客户表，支付方式表
-- Return
-- 	payment id, payment date, amount, client name, payment method
USE sql_invoicing;

SELECT 
	p.payment_id,
	p.date,
    p.amount,
	c.name AS client,
	pm.name AS 'payment method'
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    