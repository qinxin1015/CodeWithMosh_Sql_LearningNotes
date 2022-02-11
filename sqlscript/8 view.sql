-- 创建视图
USE sql_invoicing;

-- 查询客户的总销售额
SELECT 
	c.client_id,
    c.name,
    SUM(i.invoice_total) AS invoice
FROM clients c
LEFT JOIN invoices i USING (client_id)
GROUP BY c.client_id, c.name;

-- 如果以后我们要用到这个表格，比如查询最佳客户，或者没有消费的客户等，就需要重新写一遍上述查询
-- 我们可以用视图，将这个表格存起来

-- 创建一个名为sales_by_clients的视图
-- 执行sql语句不会有返回结果，而是在Views中创建了一个名为sales_by_clients的表格
CREATE VIEW sales_by_clients AS 
	SELECT 
		c.client_id,
		c.name,
		SUM(i.invoice_total) AS invoice
	FROM clients c
	LEFT JOIN invoices i USING (client_id)
	GROUP BY c.client_id, c.name;

-- 视图是一张虚拟表,我们可以直接使用这个视图,这可以大大简化我们的查询
SELECT *
FROM sales_by_clients
ORDER BY invoice DESC;

SELECT *
FROM sales_by_clients s
JOIN clients c USING(client_id);


-- EXERCISE
-- CREATE a view to see the balence for each clients
-- 结余 = 发票总额 - 支付总额
-- clients_balence
-- client_id, name, balence
CREATE VIEW clients_balence AS
	SELECT 
		c.client_id,
		c.name,
		SUM(i.invoice_total - i.payment_total) AS balence
	FROM clients c
	LEFT JOIN invoices i USING(client_id)
	GROUP BY c.client_id,c.name;  
    

-- 删除视图 
DROP VIEW clients_balence;

-- 修改视图(推荐)
CREATE OR REPLACE VIEW clients_balence AS
	SELECT 
		c.client_id,
		c.name,
		SUM(i.invoice_total - i.payment_total) AS balence
	FROM clients c
	LEFT JOIN invoices i USING(client_id)
	GROUP BY c.client_id,c.name; 


-- 可更新视图
CREATE OR REPLACE VIEW sales_with_balance AS 
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
	invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0;

-- 可以对这个视图进行删除或修改的操作
DELETE FROM sales_with_balance
WHERE invoice_id = 1;

UPDATE sales_with_balance
SET payment_date = NOW()
WHERE invoice_id = 3;

UPDATE sales_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 5;

-- 如果你没有某张表的权限，那么你可以通过视图来更新表格内容



-- with check option 子句
-- 将view中的payment_total改为invoice_total，发现执行万sql语句，invoice_id = 2的数据消失了
-- 原因：在视图中，不能更新计算相关的列
UPDATE sales_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 2;

-- 在创建视图的sql语句后加一条with check option
CREATE OR REPLACE VIEW sales_with_balance AS 
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
	invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;
-- 再次执行，就会报错，而不是直接删除invoice_id = 4的数据
UPDATE sales_with_balance
SET due_date = DATE_ADD(due_date,INTERVAL 1 DAY)
WHERE invoice_id = 4;


