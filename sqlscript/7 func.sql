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


-- SQL 中的日期函数
SELECT 
	NOW(),      # 当前的日期和时间
	CURDATE(),  # 当前的日期
	CURTIME();  # 当前的时间

-- 从日期中提取特定的值    
SELECT 
	NOW(),
	YEAR(NOW()),  # 提取 年份
	MONTH(NOW()), #      月份
	DAY(NOW()),   #      日期
    HOUR(NOW()),  #      时
    MINUTE(NOW()),#      分
    SECOND(NOW());#      秒

-- 返回字符串名称
SELECT 
	NOW(),
	DAYNAME(NOW()),   # 星期几
	MONTHNAME(NOW()); # 月份全称
    
-- EXTRACT()("提取") 函数用于返回日期/时间的单独部分，
-- 比如年、月、日、小时、分钟等等
SELECT 
	EXTRACT(YEAR FROM NOW()) AS 'YEAR',
    EXTRACT(MONTH FROM NOW()) AS 'MONTH',
    EXTRACT(DAY FROM NOW()) AS 'DAY',
    EXTRACT(YEAR_MONTH FROM NOW()) AS 'YEAR_MONTH';
    
-- EXERCISE
-- 查询当年的订单  (由于执行的年份是2022年，所以什么也查不到)
USE sql_store;

SELECT *
FROM orders
WHERE YEAR(order_date) = YEAR(CURDATE());


-- 格式化日期和时间
-- TIME_FORMAT
SELECT 
	DATE_FORMAT(NOW(), "%Y-%M-%D"), -- 日期格式化
	DATE_FORMAT(NOW(), "%Y-%m-%d"),
	TIME_FORMAT(NOW(), "%H-%i-%S"), -- 时间格式化
	TIME_FORMAT(NOW(), "%h-%p-%i-%s");


-- 计算日期和时间
-- DATE_ADD DATE_SUB
-- 在当前日期加上1天
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);

-- 在当前日期减去1年
SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR);
SELECT DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- 计算两个日期天数的间隔  DATEDIFF
SELECT DATEDIFF('2019-01-01','2019-05-01');

-- 计算秒数间隔
SELECT TIME_TO_SEC('9:00') - TIME_TO_SEC('9:02');


-- IF NULL 和 COALESCE 函数
-- IFNULL(expression, alt_value)
USE sql_store;
-- 查询订单信息：查询订单对应的shipper信息，如果为空，则表示还未分配
SELECT 
	order_id,
    IFNULL(shipper_id, 'not assigned') AS shipper
FROM orders;


-- COALESCE(alt_value1,alt_value2,alt_value3,...)
-- 返回传入的参数中第一个非null的值

-- 查询订单信息：查询订单对应的shipper信息，如果为空，则返回comments信息，如果comments为空，则返回'not assigned'
SELECT 
	order_id,
    COALESCE(shipper_id, comments,'not assigned') AS shipper
FROM orders;

-- EXERCISE
-- 查询customers表，返回顾客全名，电话（空值返回'unknown'）
SELECT 
	CONCAT(first_name,' ',last_name) AS customer,
    IFNULL(phone, 'unknown') AS phone
FROM customers;


-- IF 函数
-- IF(expression, alt_value1, alt_value2)  如果表达式为真，返回alt_value1，否则返回alt_value2

-- 查询活跃订单（2019年以后下了订单）
SELECT 
	order_id,
    order_date,
	IF(order_date > '2019-01-01', 'Active', 'Archived') AS state
FROM orders;


-- EXERCISE
-- 查看每件商品被订购的次数
USE sql_store;

SELECT 
	p.product_id,
	p.name,
    COUNT(*)  AS orders,
    IF(COUNT(*) > 1, 'Many times', 'Onces') AS frequence
FROM products p
LEFT JOIN order_items oi USING (product_id)
GROUP BY p.product_id;


-- CASE 运算符
-- 筛选多组条件
-- 筛选 2019年(active)，2018年(last year)，以及2018年以前的订单(archived)
SELECT 
	order_id,
	order_date,
    CASE
		WHEN YEAR(order_date) = 2019 THEN 'Active'
        WHEN YEAR(order_date) = 2018 THEN 'Last year'
        WHEN YEAR(order_date) < 2018 THEN 'Archived'
	END AS state
FROM orders;

-- EXERCISE
-- 根据顾客的积分，对顾客进行分级
SELECT 
	CONCAT(first_name,' ',last_name) AS customer,
    points,
    CASE 
		WHEN points >= 3000 THEN 'Gold'
        WHEN points >= 2000 THEN 'Silver'
        ELSE 'Bronze'
	END AS category
FROM customers;


