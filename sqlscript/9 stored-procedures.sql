-- Stored Procedures

-- 先来看一个简单的查询
SELECT * FROM clients;

-- 创建一个存储过程
-- 把这个sql查询存放在 存储过程 里
-- CREATE PROCEDURE 创建一个名为 get_clients() 的存储过程
DELIMITER $$ -- DELIMITER 关键字 修改默认分隔符为$$

CREATE PROCEDURE get_clients ()
BEGIN
	SELECT * FROM clients; -- 存储过程中的多条sql语句用 ; 隔开
END$$

DELIMITER ; -- 将默认人分隔符重新改为 ;

-- 默认情况下，不可能等到用户把这些语句全部输入完之后，再执行整段语句。
-- 因为mysql一遇到分号，它就要自动执行。
-- 即，在语句SELECT * FROM clients;时，mysql解释器就要执行了。
-- 这种情况下，就需要事先把delimiter换成其它符号，如//或$$。


-- 调用存储过程
CALL get_clients ();


-- EXERCISE
-- Create a stored procedure called get_invoices_with_balance
-- to return all the invoices with a balance > 0
DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance ()
BEGIN
	SELECT 
		invoice_id,
		number,
		client_id,
		invoice_total,
		payment_total,
		invoice_total - payment_total AS balance,
		invoice_date,
		due_date,
		payment_date
	FROM invoices
	WHERE invoice_total - payment_total > 0;
END$$
DELIMITER ;

-- 调用存储过程
CALL get_invoices_with_balance ();



-- 删除存储过程 
-- DROP PROCEDURE procedure_name
DROP PROCEDURE get_clients;

-- 为了防止报错，可以加上 IF EXISTS 关键字
DROP PROCEDURE IF EXISTS get_clients;


-- 创建一个存储过程的基本架构
DROP PROCEDURE IF EXISTS get_clients;

DELIMITER $$

CREATE PROCEDURE get_clients ()
BEGIN
	SELECT * FROM clients;
END
$$

DELIMITER ;

-- 我们可以将创建存储过程的sql语句保存在sql脚本中，方便以后执行调用


-- 向存储过程中传入参数
-- 创建一个根据不同州(pState)获取客户信息的存储过程
DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$

CREATE PROCEDURE get_clients_by_state 
(
	pState CHAR(2)
)
BEGIN
	SELECT * FROM clients c
    WHERE c.state = pState;
END
$$

DELIMITER ;

-- 调用procedure
-- 查询'CA'州的客户
CALL get_clients_by_state ('CA');


-- EXERCISE
-- Write a stored procedure to return invoices for a given client
DROP PROCEDURE IF EXISTS get_invoices_by_client;
DELIMITER $$

CREATE PROCEDURE get_invoices_by_client 
(
	pClient_id INT
)
BEGIN
	SELECT * FROM invoices
    WHERE client_id = pClient_id;
END
$$

DELIMITER ;


-- 查询客户id=1的发票信息
CALL get_invoices_by_client(1);


-- 带默认值的参数
-- 如果调用时没有指定州，默认查询加州'CA'
DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$

CREATE PROCEDURE get_clients_by_state 
(
	pState CHAR(2)
)
BEGIN
	IF pState IS NULL THEN
		SET pState = 'CA';
	END IF;

	SELECT * FROM clients c
    WHERE c.state = pState;
END
$$

DELIMITER ;


-- 调用procedure
CALL get_clients_by_state (NULL); -- 参数不能为空，否则mysql会报错


-- 如果调用时没有指定州，就返回所有客户信息
DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$

CREATE PROCEDURE get_clients_by_state 
(
	pState CHAR(2)
)
BEGIN
	IF pState IS NULL THEN
		SELECT * FROM clients;
	ELSE
		SELECT * FROM clients c
		WHERE c.state = pState;
	END IF;
END
$$

DELIMITER ;

-- 更简洁的写法
DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$

CREATE PROCEDURE get_clients_by_state 
(
	pState CHAR(2)
)
BEGIN
	SELECT * FROM clients c
	WHERE c.state = IFNULL(pState, c.state);
END
$$

DELIMITER ;


-- 调用procedure
CALL get_clients_by_state (NULL); -- 返回所有客户信息


-- EXERCISE
-- Write a stored procedure called get_payments
-- with two parameters
-- 		client_id => INT
-- 		payment_method_id => TINYINT
USE sql_invoicing;
DROP PROCEDURE IF EXISTS get_payments;
DELIMITER $$
CREATE PROCEDURE get_payments
(
	client_id INT,
	payment_method_id TINYINT
)
BEGIN
	SELECT * FROM payments p
	WHERE p.client_id = IFNULL(client_id, p.client_id) AND
		  p.payment_method = IFNULL(payment_method_id, p.payment_method);
END$$
DELIMITER ;

-- 查询所有的付款记录
CALL get_payments(NULL,NULL);
-- 查询id为1的客户的支付方式为1的付款记录
CALL get_payments(1,1);
-- 查询id为3的客户的所有付款记录
CALL get_payments(3,NULL);


-- 参数验证
-- 创建一个存储过程make_payments，用于更新发票信息
DROP PROCEDURE IF EXISTS make_payments;
DELIMITER $$
CREATE PROCEDURE make_payments
(
	invoice_id INT,
    payment_amount DECIMAL(9,2),
    payment_date DATE
)
BEGIN
	UPDATE invoices i
    SET i.payment_total = payment_amount,
		i.payment_date = payment_date 
	WHERE i.invoice_id = invoice_id;
END$$
DELIMITER ;

-- 将invoice_id=2的支付金额更新为30， 支付日期更新为'2020-01-01'
CALL make_payments(2, 30.0, '2020-01-01');

-- 但是，如果我们不小心写成了负数，依然可以被更新，
-- 然而，我们希望金额为负数的时候提示错误
CALL make_payments(2, -30, '2020-01-01');

-- SIGNAL SQLSTATE 抛出异常
-- 使用IF语句对参数进行验证
DROP PROCEDURE IF EXISTS make_payments;
DELIMITER $$
CREATE PROCEDURE make_payments
(
	invoice_id INT,
    payment_amount DECIMAL(9,2),
    payment_date DATE
)
BEGIN
	IF payment_amount <= 0 THEN 
		SIGNAL SQLSTATE '22003'  -- sqlstate error 代码，number out of range
			SET MESSAGE_TEXT = 'Invalid payment amount';  -- 错误提示
	END IF;
    
	UPDATE invoices i
    SET i.payment_total = payment_amount,
		i.payment_date = payment_date 
	WHERE i.invoice_id = invoice_id;
END$$
DELIMITER ;

-- 这时，输入负数的支付金额，就会报错
CALL make_payments(2, -30, '2020-01-01');


-- 存储过程的输出参数
-- 获取没有支付的客户信息,并输出查询信息
DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;
DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_client
(
	client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL
)
BEGIN
	SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id AND
		  i.payment_total = 0;
END$$
DELIMITER ;

-- 调用存储过程
set @invoices_count = 0;
set @invoices_total = 0;
call sql_invoicing.get_unpaid_invoices_for_client(3, @invoices_count, @invoices_total);
select @invoices_count, @invoices_total;

-- User / Session Variables
-- 用户变量为session级别，当我们关闭客户端或退出登录时用户变量全部消失
-- 定义变量 SET @变量名
-- 在调用具有返回值的存储过程的时候
-- 1.首先定义两个变量，并初始化为0
set @invoices_count = 0;
set @invoices_total = 0;
-- 2.在调用存储过程的时候传递变量
call sql_invoicing.get_unpaid_invoices_for_client(3, @invoices_count, @invoices_total);
-- 3.通过变量来获取返回值。
select @invoices_count, @invoices_total;


-- DECLARE 声明变量
-- SET / SELECT 为变量赋值

DROP PROCEDURE IF EXISTS get_risk_factor;
DELIMITER $$
CREATE PROCEDURE get_risk_factor ()
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0; -- DEFAULT 默认值为NULL
    DECLARE invoices_count INT;
    DECLARE invoices_total DECIMAL(9,2);
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    
    SELECT risk_factor;
END$$ -- 会话执行完，变量结束

DELIMITER ;


CALL get_risk_factor ();



-- 函数
-- 函数只能返回单一值
-- 存储过程可以返回结果集

-- 创建函数的语法
DELIMITER $$
CREATE FUNCTION `new_function` ()
RETURN INTEGER    -- 函数要明确返回值的数据类型
BEGIN

RETURN 1;
END
DELIMITER ;
-- 这与创建存储过程的语法类似


-- 创建一个函数 返回客户的风险因子
DROP function IF EXISTS `get_risk_factor_for_client`;
DELIMITER $$
CREATE FUNCTION get_risk_factor_for_client
(
	client_id INT
)
RETURNS INTEGER  
READS SQL DATA  -- 函数属性：只读取数据，不修改数据
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0; -- DEFAULT 默认值为NULL
    DECLARE invoices_count INT;
    DECLARE invoices_total DECIMAL(9,2);
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoices_total / invoices_count * 5;
	RETURN IFNULL(risk_factor,0);
END$$
DELIMITER ;


-- 在查询语句中条用自定义函数
SELECT 
	client_id,
    name,
    get_risk_factor_for_client(client_id) AS risk_factor
FROM clients;
