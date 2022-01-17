-- CROSS JOIN
-- 得到所有顾客不同种产品的组合
SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;
-- 也可以省略CROSS JOIN关键字
-- 等价于
SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c, products p
ORDER BY c.first_name;


-- Exercise
-- Do a cross join between shippers and products
-- 		using the implicit syntax
-- 		and then using the explicit syntax
SELECT 
	sh.name AS shipper,
	p.name AS product
FROM shippers sh, products p
ORDER BY shipper;
-- 等价于
SELECT 
	sh.name AS shipper,
	p.name AS product
FROM shippers sh
CROSS JOIN products p
ORDER BY shipper;
