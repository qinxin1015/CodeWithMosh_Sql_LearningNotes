-- 将orders表复制一份为orders存档
-- CREATE TABLE ... AS ...
CREATE TABLE orders_archived AS
SELECT * FROM orders;

-- 还可以向已有的表格添加数据
-- 先清空表数据
TRUNCATE TABLE orders_archived;
-- 插入2019年以前的订单信息
INSERT INTO orders_archived
SELECT * 
FROM orders
WHERE order_date < '2019-01-01';


-- Exercise
-- sql invoicing数据库中的发票表，
-- 创建invoices archived 表，存入 invoices中的部分记录
-- 要求：
-- 1.替换invoices中的client_id 为client_name（client.name）
-- 2.只筛选 已经支付过（payment_date）的发票信息
CREATE TABLE invoices_archived AS
SELECT 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i 
LEFT JOIN clients c
USING (client_id)
WHERE i.payment_date IS NOT NULL;
