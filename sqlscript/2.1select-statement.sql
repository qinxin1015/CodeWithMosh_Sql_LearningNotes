USE sql_store;    -- 选定使用的database, 你会在workbench中看到相应的database被加粗

SELECT *          -- SELECT 子句，选择需要查看的列
FROM customers    -- FROM 子句，查询的表格
-- WHERE customer_id = 1 -- 对子句进行筛选
ORDER BY first_name; -- 对查询结果进行排序

-- SELECT子句
-- 从customers表中查询客户的first_name,last_name
SELECT first_name,last_name  
FROM customers;

-- 从customers表中查询客户的first_name,last_name,points+10
SELECT first_name,last_name,points+10
FROM customers;

-- 从customers表中查询客户的first_name,last_name,(points+10) * 100
-- 将(points+10) * 100 命名为discount_factor
SELECT 
	first_name,
	last_name,
	points,
	(points+10) * 100 AS discount_factor
FROM customers;

-- 将(points+10) * 100 命名为discount factor(命名包含空格)
SELECT 
	first_name,
	last_name,
	points,
	(points+10) * 100 AS 'discount factor'
FROM customers;

-- DISTINCT 删除重复项，返回unique的结果
SELECT DISTINCT state
FROM customers;


-- Exercise
-- Return all the products
-- 	name
--  unit price
--  new price(unit price * 1.1)

SELECT 
	name, 
	unit_price, 
	unit_price * 1.1 AS 'new price'
FROM products;
