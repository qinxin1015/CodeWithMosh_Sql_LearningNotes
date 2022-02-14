-- Triggers
-- 语法
DELIMITER $$
CREATE TRIGGER trigger_name
	trigger_time
	trigger_event ON tbl_name
	FOR EACH ROW
BEGIN
	trigger_statement
END
DELIMITER ;

-- 当向payments表中插入数据的同时，(trigger_event)
-- 自动更新invoivces表的内容 (trigger_statement)
DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END$$
DELIMITER ;

-- 向payments表中插入数据
INSERT INTO payments
VALUES (DEFAULT, 5,3,'2019-01-02',100,1);
-- 执行完后，发现payments表有数据插入的同时，invoices表也有相应的改动


-- EXERCISE
-- Create a trigger that gets fired when we
-- delete a payment.
DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END$$
DELIMITER ;


-- 激活触发器
DELETE FROM payments
WHERE payment_id = 9;
-- 刷新数据库，payments中数据被删除的同时，invoices被更新


-- 查看触发器
-- 查看当前数据库下所有的触发器
SHOW TRIGGERS;
-- 查看payments开头（与payment操作相关）的触发器
SHOW TRIGGERS LIKE 'payments%';

-- 删除触发器
-- 与删除表格的语法类似
DROP TRIGGER IF EXISTS payments_after_delete;
-- 依然建议 删除语句与创建语句一起使用


-- 使用触发器进行审计
-- 可以通过触发器来保存数据库表格的修改记录，这样后面就会知道谁对表格进行了修改
CREATE TABLE payments_audit
(
	client_id 	INT 			NOT NULL,
    date    	DATE  			NOT NULL,
    amount 	  	DECIMAL(9,2)	NOT NULL,
    action_type VARCHAR(50)		NOT NULL,  -- 插入，修改，删除
    action_date DATETIME		NOT NULL
);

-- 通过触发器，在进行操作的时候，也往payments_audit中记录一下修改记录
DROP TRIGGER IF EXISTS payments_after_insert;

DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id, NEW.date, NEW.amount, 'INSERT', NOW());
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS payments_after_delete;

DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
	FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (OLD.client_id, OLD.date, OLD.amount, 'DELETE', NOW());
END$$
DELIMITER ;


-- 向payments表中插入数据
INSERT INTO payments
VALUES (DEFAULT, 5,3,'2019-01-02',100,1);
-- 1.payments中插入了一条新数据；
-- 2.invoices中相应数据被更新；
-- 3.payments_audit中新增一条数据修改记录。


-- 事件
-- Event is a task (or block of SQL code) that 
-- gets executed according to a schedule.

-- 在事件开始之前，我们要先打开MySQL事件调度器
-- MySQL事件调度器,时刻都在寻找需要执行的事件

-- 查看MySQL所有的系统变量
SHOW VARIABLES;
-- 查看event相关的变量
SHOW VARIABLES LIKE 'EVENT%'; -- event_scheduler 默认是开启状态
-- event_scheduler 	ON

-- 可以通过SET设置开启/关闭
SET GLOBAL event_scheduler = ON;
SET GLOBAL event_scheduler = OFF;


-- 创建事件的语法
DELIMITER $$
CREATE EVENT [IF NOT EXISTS] event_name
    ON SCHEDULE schedule     -- 多久执行一次事件
    [ON COMPLETION [NOT] PRESERVE]
    [ENABLE | DISABLE]
    [COMMENT 'comment']
    DO sql_statement;
DELIMITER ;

-- schedule:
--     AT timestamp [+ INTERVAL interval]
--   | EVERY interval [STARTS timestamp] [ENDS timestamp]

-- interval:
--     quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
--               WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
--               DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}

-- [ON COMPLETION [NOT] PRESERVE]可以设置这个事件是执行一次还是持久执行，默认为NOT PRESERVE。
-- [ENABLE | DISABLE]可是设置该事件创建后状态是否开启或关闭，默认为ENABLE。
-- [COMMENT 'comment']可以给该事件加上注释。


-- 创建一个事件：每年删除过期审计
DELIMITER $$

CREATE EVENT yearly_delete_state_sudit_rows
ON SCHEDULE 
	-- AT '2019-01-01'   执行一次
    -- EVERY 1 YEAR      固定周期执行一次
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN
	-- 	删除超过一年的审计
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR; 
--     WHERE action_date < DATESUB(NOW(), INTERVAL 1 YEAR);
END $$
DELIMITER ;


-- 查看、删除和更改事件
-- 查看所有事件
SHOW EVENTS;

-- 查看年度触发事件
SHOW EVENTS LIKE 'yearly%';

-- 删除事件
DROP EVENT IF EXISTS yearly_delete_state_sudit_rows;


-- 修改事件 
-- ALTER EVENT
-- 和 CREATE EVENT的语法相同

-- 通过ALTER EVENT暂时关闭事件
ALTER EVENT yearly_delete_state_sudit_rows DISABLE;  -- 暂停事件
ALTER EVENT yearly_delete_state_sudit_rows ENABLE;   -- 开启事件


