DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS prdct;
CREATE TABLE inventory (
    location_id INT,
    product_id INT,
    inventory_level INT,
    inventory_target INT
);
INSERT INTO inventory (location_id, product_id, inventory_level, inventory_target)
VALUES
(1, 101, 90, 80),
(1, 102, 100, 85),
(2, 102, 90, 80),
(2, 103, 70, 95),
(2, 104, 50, 60),
(3, 103, 120, 100),
(4, 104, 90, 102);
-- Products table
CREATE TABLE prdct (
    product_id INT,
    unit_cost DECIMAL(5,2)
);
INSERT INTO prdct (product_id, unit_cost)
VALUES
(101, 51.50),
(102, 55.50),
(103, 59.00),
(104, 50.00);

with cte as
(
select
i.location_id as location_id,
sum(inventory_level-inventory_target) as excess_insufficient_qty,
sum((inventory_level-inventory_target)*p.unit_cost) as excess_insufficient_value
from inventory i
inner join prdct p on i.product_id=p.product_id
group by i.location_id
)
select
CAST(location_id as CHAR) as location_id ,
excess_insufficient_qty,
excess_insufficient_value
from cte
union all
select
'Overall' as location_id
, sum(excess_insufficient_qty) as excess_insufficient_qty
, sum(excess_insufficient_value) as excess_insufficient_value
from cte
ORDER BY location_id;

-- OR ******************************************************

SELECT 
    COALESCE(i.location_id, 'Overall') AS location_id,
    SUM(CASE WHEN i.inventory_level > i.inventory_target 
             THEN i.inventory_level - i.inventory_target ELSE 0 END) AS excess_units,
    SUM(CASE WHEN i.inventory_level > i.inventory_target 
             THEN (i.inventory_level - i.inventory_target) * p.unit_cost ELSE 0 END) AS excess_cost,
    SUM(CASE WHEN i.inventory_level < i.inventory_target 
             THEN i.inventory_target - i.inventory_level ELSE 0 END) AS insufficient_units,
    SUM(CASE WHEN i.inventory_level < i.inventory_target 
             THEN (i.inventory_target - i.inventory_level) * p.unit_cost ELSE 0 END) AS insufficient_cost
FROM inventory i
JOIN prdct p 
  ON i.product_id = p.product_id
GROUP BY i.location_id WITH ROLLUP
ORDER BY i.location_id;