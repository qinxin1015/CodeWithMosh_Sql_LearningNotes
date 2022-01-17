-- LIKE 运算符： 用于模糊查询
-- 查询以B为首字母的姓氏的顾客的信息
SELECT * 
FROM customers
WHERE last_name LIKE 'b%';

-- 查询以包含B字母的姓氏的顾客的信息
SELECT * 
FROM customers
WHERE last_name LIKE '%b%';

-- 查询以y字母结尾且总共为6个字母的姓氏的顾客的信息
SELECT * 
FROM customers
WHERE last_name LIKE '_____y'; -- 5个"_"


-- Exercise
-- Get the customers whose
-- 	addresses contain TRAIL or AVENUE
SELECT *
FROM customers
where address like '%trail%' 
   OR address like '%avenue%';
   
-- 	phone numbers end with 9
SELECT *
FROM customers
where phone like '%9';

