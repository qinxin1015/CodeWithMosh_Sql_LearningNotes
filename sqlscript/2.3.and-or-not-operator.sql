-- AND 运算符
-- 查询1990年以后出生且积分大于1000的顾客信息
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01'
	AND points > 1000;

-- OR 运算符
-- 查询1990年以后出生，或者积分大于1000且state为VA的顾客信息
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01'
	OR points > 1000
    AND state = 'VA';
    
-- 下面执行的结果相同    
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01'
	OR 
    (points > 1000 AND state = 'VA');
    
-- NOT 运算符
-- 查询既不是1990年以后出生，也不是积分大于1000的顾客的信息
SELECT * 
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR 
		   points > 1000);
            
-- 等价于
SELECT * 
FROM customers
WHERE birth_date <= '1990-01-01' AND 
	  points <= 1000;
      
-- Exercise
-- From the order_items tables,get the items
-- 	for order # 6
-- 	where the total price is greater than 30
SELECT *
FROM order_items
WHERE order_id = 6 AND quantity*unit_price > 30;

