DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id VARCHAR(20),
    category VARCHAR(10),
    unit_price INT,
    quantity INT
);
INSERT INTO orders (order_id, product_id, category, unit_price, quantity) VALUES
(100, 'Chair-1221',   'Furniture', 1500, 1),
(101, 'Table-3421',   'Furniture', 2000, 3),
(102, 'Chair-1221',   'Furniture', 1500, 2),
(103, 'Table-9762',   'Furniture', 7000, 2),
(104, 'Shoes-1221',   'Footwear', 1700, 1),
(105, 'floaters-3421','Footwear', 2000, 1),
(106, 'floaters-3421','Footwear', 2000, 2),
(107, 'floaters-9875','Footwear', 1500, 2);


/*select category, product_id
from 
(select category,product_id,sum(quantity) as total,
sum(unit_price*quantity) as sales,
rank() over (partition by category order by sum(quantity) desc) as sales_rank
from orders group by product_id,category) as r
where sales_rank=1
order by category;*/

/* Your requirement was:
Pick product with highest quantity
If tie → prefer higher sales value
But your query only orders by quantity.
So in case of tie (same quantity for 2 products), 
both will get rank = 1 → you’ll get both rows, even if one has lower sales. */

select category, product_id
from 
(select category,product_id,sum(quantity) as total,
sum(unit_price*quantity) as sales,
rank() over (partition by category order by sum(quantity) desc, sum(unit_price*quantity) desc) as sales_rank
from orders group by product_id,category) as r
where sales_rank=1
order by category;
