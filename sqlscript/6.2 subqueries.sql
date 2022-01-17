USE sql_store;
-- Find products that are more expensive than Lettuce (id = 3)
-- 2 step queries
-- 1. select Lettuce unit_price when product_id = 3
-- 2. select everything which unit_price > Lettuce unit_price
SELECT * 
FROM products
WHERE unit_price > (
SELECT unit_price
FROM products
WHERE product_id = 3
);
-- 这个子查询卸载where子句里，其实也可以写在from子句和select子句里，我们后面会讲到


-- Exercise
-- In sql_hr database
-- 		Find employees whoses earn more than average
USE sql_hr;

SELECT *
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

