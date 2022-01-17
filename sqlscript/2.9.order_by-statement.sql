-- ORDER BY 子句， 依据某一字段排序
-- ASC 升序（默认）；DESC 降序
-- 查询顾客信息，并通过名字升序排序
SELECT * 
FROM customers
ORDER BY first_name;
-- 查询顾客信息，并通过名字降序排序
SELECT * 
FROM customers
ORDER BY first_name DESC;

-- 多字段排序
-- 查询顾客信息，先通过州升序排序，再通过名字升序排序
SELECT * 
FROM customers
ORDER BY state, first_name;

-- Exercise
-- 查询 order_items 表格，
-- 		订单号为2
-- 		且按照总价格降序

-- 1. 订单号为2
SELECT * 
FROM order_items
WHERE order_id = 2;
-- 2. 按照总价格降序
SELECT * 
FROM order_items
ORDER BY quantity * unit_price DESC;
-- 合并两个条件：订单号为2，且按照总价格降序
SELECT * 
FROM order_items
WHERE order_id = 2
ORDER BY quantity * unit_price DESC;

-- 新增一列total price
SELECT * ,quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;