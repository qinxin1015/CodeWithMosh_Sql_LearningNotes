-- 事务
-- Transaction is a group of SQL statements that 
-- represent a single unit of work.

-- 我们希望对数据库的更改的一组SQL作为一个单元，一起提交成功/失败

-- 事务的属性：
-- 原子性。要么一个单元的所有任务被执行，要么所有执行被撤销。
-- 一致性。通过使用事务，数据库将始终保持一致的状态。
-- 隔离性。事务之间相互隔离。
-- 持久性。一旦事务被提交，事务产生的更改是永久的。


-- 创建事务
-- 创建一个事务，存储一组带有项目的订单。
USE sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id, order_state,status)
VALUES (1, '2019-01-01', 1);

INSERT INTO order_items
VALUES (last_insert_id(), 1, 2, 10);

COMMIT;

-- MySQL会依次执行所有的指令，只要其中一项执行失败，MySQL就会撤销之前所有的操作。

-- 有时候，执行一半操作发现有问题，可以手动回退
ROLLBACK; -- 可以回退事务的所有操作


-- 我们在MySQL提交命令的时候，mysql默认也会将用户的操作当做事务即时提交。
SHOW VARIABLES LIKE 'autocommit%';
-- autocommit : ON


-- 并发和锁定
-- 并发：两个以上的人同时操作一个数据库的数据。
-- 锁定：MySQL默认会对数据进行锁定，而避免并发的发生。


-- 并发问题
-- 当两个事务同时更新相同的数据，并没有上锁，就会发生并发问题
-- 并发发生的时候，较晚提交的事务会覆盖较早事务进行的更改。


-- 查看事务的隔离级别
SHOW VARIABLES LIKE 'transaction_isolation';

-- 设置隔离级别
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- 序列化隔离

-- 设置会话隔离
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- 序列化隔离
-- 设置全局隔离
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE; -- 序列化隔离


-- 1.读未提交隔离级别（没有隔离）
-- USER 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT points
FROM customers
WHERE customer_id = 1;

-- USER 2
-- 逐行执行
USE sql_store;                -- 执行
START TRANSACTION;			  -- 执行
	UPDATE customers		  -- 执行
	SET points = 20			  -- 执行
	WHERE customer_id = 1;	  -- 执行
COMMIT;						  -- 未执行


-- 2.读已提交隔离级别
-- USER 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT points
FROM customers
WHERE customer_id = 1;

-- USER 2
-- 逐行执行
USE sql_store;                -- 执行
START TRANSACTION;			  -- 执行
	UPDATE customers		  -- 执行
	SET points = 20			  -- 执行
	WHERE customer_id = 1;	  -- 执行
COMMIT;						  -- 未执行

-- 读已提交隔离级别，会出现不重复读的情况（即可能两次读取不一致）
-- USER 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;			-- 执行
SELECT points				-- 执行
FROM customers				-- 执行
WHERE customer_id = 1;		-- 执行  得到 points：2272
-- 暂停执行，先去USER 2 执行对customers表的修改  SET points = 20
SELECT points				-- 继续执行
FROM customers
WHERE customer_id = 1;      -- 这个时候会得到 points：20
COMMIT;	

-- USER 2
USE sql_store;                
START TRANSACTION;			  
	UPDATE customers		  
	SET points = 20			  
	WHERE customer_id = 1;	  
COMMIT;						 


-- 3.可重复隔离级别
-- 可重复隔离级别 保证事务内部数据读取的一致性
-- USER 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;			-- 执行
SELECT points				-- 执行
FROM customers				-- 执行
WHERE customer_id = 1;		-- 执行  得到 points：2272
-- 暂停执行，先去USER 2 执行对customers表的修改  SET points = 20
SELECT points				-- 继续执行
FROM customers
WHERE customer_id = 1;      -- 这个时候仍然得到 points：2272
COMMIT;	

-- USER 2
USE sql_store;                
START TRANSACTION;			  
	UPDATE customers		  
	SET points = 20			  
	WHERE customer_id = 1;	  
COMMIT;			

-- 可重复隔离级别，无法解决幻读的问题
-- 用户1在提交事务的过程中（commit之前），用户2对customers表进行了修改，
-- 但是用户1无法检测到用户2的修改
-- USER 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;			
SELECT * FROM customers				
WHERE state = 'VA';		
COMMIT;	                -- 只能查到customer_id = 2 的客户

-- USER 2
USE sql_store;                
START TRANSACTION;			  
	UPDATE customers		  
	SET state = 'VA'			  
	WHERE customer_id = 1;	  
COMMIT;		

-- 4.序列化隔离级别
-- 序列化隔离级别，可以真正消除并发问题

-- 用户1在提交事务的过程中（commit之前），用户2对customers表进行了修改，
-- 但是用户1会等待用户2的修改提交结束，重新执行查询事务

-- USER 1
USE sql_store;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;			
SELECT * FROM customers				
WHERE state = 'VA';		
COMMIT;	                -- 可以查到customer_id = 1和2 的两个客户

-- USER 2
USE sql_store;                
START TRANSACTION;			  
	UPDATE customers		  
	SET state = 'VA'			  
	WHERE customer_id = 1;	  
COMMIT;		




-- 死锁
-- 用户1和用户2同时提交事务，
-- 用户1修改customers时，数据库对customer_id = 1这条数据进行了锁定，
-- 用户2修改orders时，order_id = 1这条数据也进行了锁定，
-- 此时，用户1等待用户2提交结束；用户2等待用户1提交结束，然而两个用户因为在等待对方都无法继续，这就导致了死锁。

-- USER 1
USE sql_store;

START TRANSACTION;
UPDATE customers SET state = 'VA' WHERE customer_id = 1;
UPDATE orders SET status = 1 WHERE order_id = 1; -- 等待USER 2 更新orders表
COMMIT;

-- USER 2
USE sql_store;

START TRANSACTION;
UPDATE orders SET status = 1 WHERE order_id = 1;
UPDATE customers SET state = 'VA' WHERE customer_id = 1;-- 等待USER 1 更新customers表
COMMIT;

-- 死锁发生的时候，一般会选择重复执行一次，
-- 死锁只能尽可能减少它的发生，而不能真正消除。