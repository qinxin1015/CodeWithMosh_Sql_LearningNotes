-- Select invocies larger than all invoices of client 3
USE sql_invoicing;
-- Solution 1 子查询
SELECT *
FROM invoices
WHERE invoice_total > (
	SELECT Max(invoice_total)
	FROM invoices
	WHERE client_id = 3
);

-- Solution 2 ALL 关键字
SELECT *
FROM invoices
WHERE invoice_total > ALL(
	SELECT invoice_total
	FROM invoices
	WHERE client_id = 3
);


