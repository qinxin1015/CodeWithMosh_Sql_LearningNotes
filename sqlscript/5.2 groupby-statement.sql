-- GROUP BY
-- 1.筛选2019下半年的数据
-- 2.按照gorup by 指定的列进行分组，
-- 3.再对组内数据调用聚合函数进行计算
-- 4.最后对结果进行降序排列
SELECT 
	client_id,
    SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales desc;

-- 查询每个州-城市的总销售额
SELECT 
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients USING (client_id)
GROUP BY state, city;


-- Exercise
-- 查询每天刷卡支付和现金支付各收入了多少
-- Return 
-- 		date, payment method and total payments
SELECT 
	p.date, 
	pm.name AS payment_method,
    SUM(p.amount) AS total_payments
FROM payments p
JOIN payment_methods pm
ON P.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY date;
