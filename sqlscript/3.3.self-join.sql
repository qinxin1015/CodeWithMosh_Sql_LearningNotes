USE sql_hr;
-- 查询员工给工作汇报上级
SELECT 
	e.employee_id,
	e.first_name AS employee,
	m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;