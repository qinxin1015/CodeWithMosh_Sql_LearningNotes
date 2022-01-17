-- 筛选发票总额大于500，且发票张数大于5的客户
SELECT 
	client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS num_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales > 500
	AND num_of_invoices > 5;
    

-- Exercise
-- Get the customers
-- 		located in Virgina
-- 		who have spent more than $100
SELECT 
	c.customer_id,
	c.first_name,
    c.last_name,
    SUM(oi.unit_price * oi.quantity) AS spent_amount
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE c.state = 'VA'
GROUP BY 	
	c.customer_id
	-- c.first_name,
    -- c.last_name
HAVING spent_amount > 100;