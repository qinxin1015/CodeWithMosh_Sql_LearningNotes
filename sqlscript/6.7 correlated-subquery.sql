-- Select employees whose salary is above the average in their office
USE sql_hr;
-- 查询每个部门的平均工资
SELECT 
	office_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY office_id;
-- 利用相关子查询
SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
);


-- Exercise
-- Get invoices that are larger than the client's average invoice amount
USE sql_invoicing;

-- the client's average invoice amount
SELECT client_id, AVG(invoice_total)
FROM invoices 
GROUP BY client_id;

-- Get invoices that are larger than the client's average invoice amount
SELECT * 
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
	FROM invoices 
    WHERE client_id = i.client_id
)


