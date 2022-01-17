-- REGEXP: reguler expression 正则表达式
-- 查询姓氏中包含field的顾客的信息
SELECT * 
FROM customers
WHERE last_name LIKE '%field%';
-- 等价于
SELECT * 
FROM customers
WHERE last_name REGEXP 'field';

-- 查询姓氏中包含field或者mac的顾客的信息
SELECT * 
FROM customers
WHERE last_name REGEXP 'field|mac';

-- 查询姓氏中以field结尾或者以mac开头或者包含rose的顾客的信息
SELECT * 
FROM customers
WHERE last_name REGEXP 'field$|^mac|rose';

-- 查询姓氏中包含ge或者ie或者me的顾客的信息
SELECT * 
FROM customers
WHERE last_name REGEXP '[gim]e';

-- [a-h] 等价于 [abcdefg]
SELECT * 
FROM customers
WHERE last_name REGEXP '[a-h]e';

-- Exercise
-- Get the customers whose
-- 		1.first names are ELKA or AMBUR
-- 		2.last names end with EY or ON
-- 		3.last names start with MY or contains SE
-- 		4.last names contan B followed by R or U

-- 1.first names are ELKA or AMBUR
SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';
-- 2.last names end with EY or ON
SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';
-- 3.last names start with MY or contains SE
SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';
-- 4.last names contan B followed by R or U
SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]';