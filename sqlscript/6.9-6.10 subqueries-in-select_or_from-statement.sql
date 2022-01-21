-- SELECT 中的子查询
USE sql_invoicing;
-- SELECT 中的表达式不能使用别名
SELECT 
	invoice_id,
    invoice_total,
    (SELECT avg(invoice_total) FROM invoices) AS avg_invoice,
    invoice_total - (SELECT avg(invoice_total) FROM invoices) AS difference
FROM invoices;
-- SELECT 中的子查询
-- 不能直接使用别名计算，可以使用 "SELECT 别名" 进行计算
SELECT 
	invoice_id,
    invoice_total,
    (SELECT avg(invoice_total) FROM invoices) AS avg_invoice,
    invoice_total - (SELECT avg_invoice) AS difference
FROM invoices;

-- Exercise
-- SELECT clients and invoices, Return
-- 		client_id, name, total_sales, average, difference
-- 用到相关子查询和select子句的子查询
SELECT
	client_id,
    name,
    (SELECT SUM(invoice_total)
    FROM invoices
    WHERE client_id = c.client_id) AS total_sales,
	(SELECT AVG(invoice_total)
    FROM invoices) AS average,
    (SELECT total_sales - average) AS difference
FROM clients c;


-- FROM 子句中的子查询
SELECT *
FROM (
	SELECT
		client_id,
		name,
		(SELECT SUM(invoice_total)
		FROM invoices
		WHERE client_id = c.client_id) AS total_sales,
		(SELECT AVG(invoice_total)
		FROM invoices) AS average,
		(SELECT total_sales - average) AS difference
	FROM clients c
) AS sales_summary
WHERE total_sales IS NOT NULL;