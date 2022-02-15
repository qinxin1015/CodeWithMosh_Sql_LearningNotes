
-- 添加一列properties，数据类型为JSON， 默认值为NULL
ALTER TABLE `sql_store`.`products` 
ADD COLUMN `properties` JSON NULL DEFAULT NULL AFTER `unit_price`;

-- 用JSON格式为properties更新数据
UPDATE products
SET properties = '
{
	"dimentions": [1,2,3],
    "weight": 10,
    "manufacturer": {"name":"sony"}
}'
WHERE product_id = 1;

-- 查看更新结果
SELECT properties 
FROM products
WHERE product_id = 1;
-- '1', 'Foam Dinner Plate', '70', '1.21', '{\"weight\": 10, \"dimentions\": [1, 2, 3], \"manufacturer\": {\"name\": \"sony\"}}'


-- 用JSON_OBJECT为properties更新数据 这也会得到相同的结果
UPDATE products
SET properties = JSON_OBJECT(
	'weight',10, 
    'dimentions',JSON_ARRAY(1,2,3),
    'manufacturer',JSON_OBJECT('name','sony')
    )
WHERE product_id = 1;


-- 从JSON文件中提取数据
SELECT 
	product_id,
    JSON_EXTRACT(properties, "$.weight") AS weight
FROM products
WHERE product_id = 1;

-- 还有一种更简单的写法
SELECT 
	product_id,
    properties -> "$.weight" AS weight,
    properties -> "$.dimentions[0]" AS dimention_0, -- JSON 中的array可以用元素索引取值
	properties ->> "$.manufacturer.name" AS manufacturer -- ->> 可以去掉字符串两边的双引号
FROM products
WHERE product_id = 1;

-- 还可以用作筛选条件
-- 只筛选sony的产品
SELECT *
FROM products
WHERE properties ->> "$.manufacturer.name" = 'sony';


-- JSON_SET 只更新/添加JSON的部分属性
UPDATE products
SET properties = JSON_SET(
	properties,
    '$.weight',20,  -- 修改weight属性
    '$.age',10      -- 新增age属性
)
WHERE product_id = 1;


-- JSON_REMOVE 删除部分属性
UPDATE products
SET properties = JSON_REMOVE(
	properties,
    '$.age'      -- 删除age属性
)
WHERE product_id = 1;