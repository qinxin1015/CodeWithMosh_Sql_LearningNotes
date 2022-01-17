USE sql_hr;
-- 查询每个员工的直属领导，如果没有直属领导，则返回null
SELECT 
	e.employee_id,
	e.first_name AS employee,
	m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;