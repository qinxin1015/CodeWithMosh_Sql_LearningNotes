-- WHERE 子句
-- WHERE 筛选 积分points大于3000的顾客
SELECT * 
FROM customers
WHERE points > 3000;

-- WHERE 筛选 州state为VA的顾客
SELECT * 
FROM customers
WHERE state = 'VA';

-- WHERE 筛选 1990年以后出生的人
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01';


-- Exercise
-- Get the orders placed this year (2019)

SELECT *
FROM orders
WHERE order_date >= '2019-01-01';