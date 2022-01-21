-- MYSQL 数值函数
-- ROUND() 四舍五入
SELECT ROUND(5.73);         -- 6
SELECT ROUND(5.7355, 2);    -- 5.74
-- TRUNCATE() 截断函数, 移除指定位数的数字，不考虑四舍五入
SELECT TRUNCATE(5.7355, 2); -- 5.73
-- CEILING() 向上取整
SELECT CEILING(5.2);        -- 6
-- FLOOR()   向下取整
SELECT FLOOR(5.9);          -- 5
-- ABS()    绝对值
SELECT ABS(-5.9);           -- 5.9
-- RAND()  随机生成 0-1 的浮点数
SELECT RAND();


-- MYSQL 字符串函数
-- LENGTH()  返回字符串的长度
SELECT LENGTH('SKY');       -- 3
-- UPPER()   全部变为大写字母
SELECT UPPER('hello');      -- HELLO
-- LOWER()   全部变为小写字母
SELECT LOWER('WORLD');      -- world
-- LTRIM()  移除字符串左边的空白字符或其他预定义字符
SELECT LTRIM('  Sky  ');    -- 'Sky  ' 
-- RTRIM()  移除字符串右边的空白字符或其他预定义字符
SELECT RTRIM('  Sky  ');    -- '  Sky' 
-- TRIM()  移除字符串两边的空白字符或其他预定义字符
SELECT RTRIM('  Sky  ');    -- 'Sky' 
-- LEFT(string, n)  获取字符串左边n个字符
SELECT LEFT('Kindergaten', 4);    -- Kind
-- RIGHT(string, n)  获取字符串右边n个字符
SELECT RIGHT('Kindergaten', 4);    -- aten
-- SUBSTRING(string, start, len)  获取字符串(包含)起始位置开始的len个字符
SELECT SUBSTRING('Kindergaten', 4, 3);  -- der
-- LOCATE(substring, string)  返回查找到substring的第一个字符（串）在string中的位置
SELECT LOCATE('der', 'Kindergaten');    -- 4
-- 查询不到会返回0
SELECT LOCATE('que', 'Kindergaten');    -- 0
-- REPLACE(string, substring,replacestring)  将字符串中，substring替换为replacestring
SELECT REPLACE('Kindergaten', 'gaten','garden'); -- Kindergarden
-- CONCAT(string1, string2)  连接两个字符串
SELECT CONCAT('Kinder', 'garden');    -- Kindergarden
-- eg. 连接 姓和名，组成完整的姓名
USE sql_store;
SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customers;


-- MYSQL 日期函数