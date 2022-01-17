-- DELETE ONE ROW
-- 删除客户名称为'Myworks'的发票信息
-- 1. 查询客户名称为'Myworks'的发票信息
SELECT * FROM invoices
WHERE client_id = (
	SELECT client_id 
	FROM clients
	WHERE name = 'Myworks'
);
-- 2. 删除刚刚查询到的信息
DELETE FROM invoices
WHERE client_id = (
	SELECT client_id 
	FROM clients
	WHERE name = 'Myworks'
)
-- 你再次执行第一步的查询就无法查到信息了