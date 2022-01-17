-- IN 运算符
-- 从customers表中，查询位于Virginia或者位于Florida或者位于Georgia的顾客的信息
SELECT * 
FROM customers
WHERE state = 'VA' 
   OR state = 'FL' 
   OR state = 'GA';
   
-- 等价于
SELECT * 
FROM customers
WHERE state IN ('VA','FL','GA');

-- Exercise
-- Return products with
-- 	quantity in stock equal to 49, 38, 72
SELECT * 
FROM products
WHERE quantity_in_stock IN (49, 38, 72);