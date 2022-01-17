-- 插入分层表
INSERT INTO orders (customer_id, order_date,status)
VALUES (1, '2019-01-02', 1);

-- SELECT LAST_INSERT_ID()：
-- 得到刚 insert 到orders记录的主键值order_id，只适用与自增主键
INSERT INTO order_items
VALUES
	(LAST_INSERT_ID(), 1, 1, 2.35),
    (LAST_INSERT_ID(), 2, 1, 3.95),
    (LAST_INSERT_ID(), 3, 1, 2.35);