-- UNION
-- 给每一笔订单加一个标签，如果是今年的为活跃active, 之前的为存档 archive
-- 假设'今年'是'2019年'
-- 通过UNION 关键字，可以合并多段查询的结果
SELECT *, 'Active' AS status
FROM orders
WHERE order_date > '2019-01-01'
UNION
SELECT *, 'Archive' AS status
FROM orders
WHERE order_date <= '2019-01-01';

-- 也可以基于不同的表得到的结果集进行合并
-- 查询所有顾客和发货人
SELECT first_name 
FROM customers
UNION
SELECT name
FROM shippers


-- Exercise
-- 根据积分对用户进行分组：
-- 		积分小于2000：青铜
-- 		积分大于2000且小于3000：白银
--      积分大于3000：黄金
-- Return
-- 		customer_id, first_name,points,type
SELECT 
	customer_id,
    first_name,
    points,
    'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Silver' AS type
FROM customers
WHERE 2000 <= points < 3000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers
WHERE points >= 3000;
