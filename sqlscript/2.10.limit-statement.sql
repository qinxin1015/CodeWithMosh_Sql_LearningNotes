-- LIMIT 子句， 指定返回数据条数
-- 查看前3名顾客
SELECT * 
FROM customers
LIMIT 3;

-- set offset
-- 这个在分页场景中经常使用
-- page 1: 1-3
-- page 2: 4-6
-- page 3: 7-9 *
-- 假设现在在page 2, 查询page 3
-- 即 查询7，8，9三行
SELECT * 
FROM customers
LIMIT 6, 3;


-- Exercise
-- Get the top three loyal customers
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;