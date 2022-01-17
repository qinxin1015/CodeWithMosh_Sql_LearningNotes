-- 在多表外连接中，尽量只是用 LEFT JOIN
-- 查询一个用户的ID， 名字，订单号，发货人
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id,
    s.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers s
	ON o.shipper_id = s.shipper_id;
    

-- Exercise
-- Return
-- 		order_date, order_id,(订单表)
-- 		first_name,（客户表）
-- 		shipper,（托运人表）
-- 		status,（订单状态表）
SELECT 
	o.order_date,
    o.order_id,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
LEFT JOIN order_statuses os
	ON o.status = os.order_status_id
ORDER BY status;