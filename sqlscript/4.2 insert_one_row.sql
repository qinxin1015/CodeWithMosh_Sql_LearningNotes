-- INSERT one row
INSERT INTO customers
VALUES 
	(DEFAULT, 'Join','Smith','1990-01-01',DEFAULT,'address','city','CA',DEFAULT);
-- 等价于
INSERT INTO customers(
	first_name, last_name,birth_date,address,city,state
)
VALUES 
	('Join','Smith','1990-01-01','address','city','CA');