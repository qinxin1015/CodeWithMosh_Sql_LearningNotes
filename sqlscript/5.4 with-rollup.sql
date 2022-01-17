-- 计算每个州，每个城市的总销售额，
-- WITH ROLLUP 计算每组的汇总数据
SELECT 
	c.state, 
    c.city,
    SUM(i.invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY c.state, c.city WITH ROLLUP;


-- Exercise
-- Return
-- 		payment method, total payment
-- 		及其汇总数据
SELECT 
	pm.name AS 'payment method',
    SUM(amount) AS total
FROM payments p
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
GROUP BY 'payment method' WITH ROLLUP;
-- 这里会报错，因为当使用WITH ROLLUP的时候，GROUP BY子句就不可以使用列的别名了
SELECT 
	pm.name AS 'payment method',
    SUM(amount) AS total
FROM payments p
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP;  
    