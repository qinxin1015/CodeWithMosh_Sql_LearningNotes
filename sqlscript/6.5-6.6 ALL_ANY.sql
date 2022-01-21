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


-- ANY / SOME 满足条件的任何一个即可
-- Select clients with at least two invoices
-- Solution 1
SELECT *
FROM clients
WHERE client_id IN (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);

-- Solution 2 'IN' 可以用 '= ANY'替换
SELECT *
FROM clients
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);

