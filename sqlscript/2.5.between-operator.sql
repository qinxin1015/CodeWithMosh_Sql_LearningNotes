-- BETWEEN 运算符
-- 从customers表查询积分在1000~3000的顾客的信息
SELECT *  
FROM customers
WHERE points BETWEEN 1000 AND 3000;

-- 等价于
SELECT *  
FROM customers
WHERE points >= 1000 
  AND points <=3000;
  
  
-- Exercise
-- Return customers born
-- 		between 1/1/1990 and 1/1/2000
SELECT *  
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';