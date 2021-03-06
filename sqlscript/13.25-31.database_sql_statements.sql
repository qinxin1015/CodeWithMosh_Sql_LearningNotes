-- 创建数据库
CREATE DATABASE IF NOT EXISTS sql_store2;
-- 删除数据库
DROP DATABASE IF EXISTS sql_store2;


-- 在sql_store2中建表
CREATE DATABASE IF NOT EXISTS sql_store2;
USE sql_store2;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers
(
	customer_id INT PRIMARY KEY AUTO_INCREMENT, -- 客户id: 整型、主键、非空
    first_name	VARCHAR(50) NOT NULL,			-- 姓名：字符串、非空
    points		INT NOT NULL DEFAULT 0,			-- 积分：整型、非空、默认值为0
    email		VARCHAR(255) NOT NULL UNIQUE	-- 邮箱：字符串、非空、唯一
);


-- 修改表格
ALTER TABLE customers
	ADD last_name VARCHAR(50) NOT NULL AFTER first_name,
    ADD city		VARCHAR(50) NOT NULL,
    MODIFY COLUMN first_name VARCHAR(50) DEFAULT '',
    DROP points;


-- 创建关系
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
	order_id	INT PRIMARY KEY,
    customer_id	INT NOT NULL,
    FOREIGN KEY fk_orders_customers (customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE    -- 主表更新时，副表级联更新  
        ON DELETE NO ACTION	 -- 主表删除时，副表不允许删除
);


-- 更改主键和外键约束
-- 如果我们在建表的时候，忘记添加关系了
ALTER TABLE orders
-- 	ADD PRIMARY KEY (order_id),
	DROP FOREIGN KEY fk_orders_customers,
    ADD FOREIGN KEY	fk_orders_customers (customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE        
        ON DELETE NO ACTION;	


-- 字符集和排序规则
-- 显示MySQL支持的字符集及其默认的排序方式
SHOW CHARSET;

-- 建表的时候指定字符集
CREATE TABLE sql_store
(
)
CHARSET SET latin1;

-- 更改一个表的字符集
ALTER TABLE sql_store
CHARSET SET latin1;


-- 显示MySQL支持的引擎
SHOW ENGINES;
-- 最常用的 'MyISAM'和'InnoDB'
-- 'MyISAM'：MySQL 5.5以前的
-- 'InnoDB'：它支持事务等高级功能，本节课的内容都是基于InnoDB

ALTER TABLE customers
ENGINE = InnoDB; 