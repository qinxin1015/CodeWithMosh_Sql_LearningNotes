-- 聚合函数
-- SUM()求和的时候会自动忽略NULL
SELECT 
	MAX(invoice_total) AS highest,
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total) AS total,
    COUNT(invoice_total) AS number_of_invoices,
    COUNT(payment_date) AS count_of_payments
FROM invoices;

-- 聚合函数内部可以使用表达式
SELECT 
	MAX(invoice_total) AS highest,
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total * 1.1) AS total,
    COUNT(*) AS total_records
FROM invoices
WHERE invoice_date > '2019-07-01';


-- Exercise
-- SELECT invoices table and Return
-- 		total sales, total payments, 以及这两列的插值
-- 		First half of 2019, Second half of 2019

SELECT 
	'First half of 2019' AS 'date range',
	SUM(invoice_total) AS 'total sales',
    SUM(payment_total) AS 'total payments',
    ABS(SUM(invoice_total)-SUM(payment_total)) AS 'what we expect'
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'Second half of 2019' AS 'date range',
	SUM(invoice_total) AS 'total sales',
    SUM(payment_total) AS 'total payments',
    ABS(SUM(invoice_total)-SUM(payment_total)) AS 'what we expect'
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-30'
UNION
SELECT 
	'Total' AS 'date range',
	SUM(invoice_total) AS 'total sales',
    SUM(payment_total) AS 'total payments',
    ABS(SUM(invoice_total)-SUM(payment_total)) AS 'what we expect'
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-30';