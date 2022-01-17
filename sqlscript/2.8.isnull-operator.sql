-- IS NULL 运算符
-- 查询phone number 为空的行
SELECT * 
FROM customers
WHERE phone IS NULL;

-- 查询phone number 非空的行
SELECT * 
FROM customers
WHERE phone IS NOT NULL;


-- Exercise
-- Get the orders that are not shipped
SELECT * 
FROM orders
WHERE shipped_date IS NULL;
