CREATE TABLE productss(
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(10)
);

INSERT INTO productss VALUES
(1,'Apples'),(2,'Bananas'),(3,'Oranges');

-- sales
DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
  sale_id       INT PRIMARY KEY,
  product_id    INT,
  region_name   VARCHAR(20),
  sale_date     DATE,
  quantity_sold INT
);

INSERT INTO sales VALUES
(1, 1, 'North America','2023-03-15',200),
(2, 1, 'North America','2023-06-20',300),
(3, 1, 'North America','2023-09-10',250),
(4, 1, 'North America','2023-11-25',300),
(5, 2, 'Europe',       '2023-04-25',150),
(6, 2, 'Europe',       '2023-07-30',200),
(7, 2, 'Europe',       '2023-10-15',180),
(8, 2, 'Europe',       '2023-01-20',220),
(9, 3, 'Asia',         '2023-05-05',300),
(10,3, 'Asia',         '2023-08-10',350),
(11,3, 'Asia',         '2023-11-20',400);

-- seasons for 2023
CREATE TABLE seasons(
  season_name VARCHAR(10),
  start_date  DATE,
  end_date    DATE
);
INSERT INTO seasons VALUES
('Winter','2023-01-01','2023-02-28'),
('Spring','2023-03-01','2023-05-31'),
('Summer','2023-06-01','2023-08-31'),
('Autumn','2023-09-01','2023-12-31');



WITH topsellingproductsregion AS (
  SELECT
    s.region_name AS rname,
    s.product_id  AS pid,
    p.product_name
  FROM productss p
  JOIN sales s
    ON p.product_id = s.product_id
  WHERE YEAR(s.sale_date) = 2023
  GROUP BY s.region_name, s.product_id, p.product_name
  HAVING SUM(s.quantity_sold) = (
    SELECT MAX(t.total_qty)
    FROM (
      SELECT SUM(quantity_sold) AS total_qty
      FROM sales s2
      WHERE s2.region_name = s.region_name
        AND YEAR(s2.sale_date) = 2023
      GROUP BY s2.product_id
    ) t
  )
)
SELECT
  rname,
  pid,
  product_name,
  SUM(quantity_sold) AS total_quantity,
  se.season_name AS season
FROM sales s
JOIN seasons se
  ON s.sale_date BETWEEN se.start_date AND se.end_date
JOIN topsellingproductsregion t
  ON t.rname = s.region_name
 AND t.pid   = s.product_id
WHERE YEAR(s.sale_date) = 2023
GROUP BY season, rname, pid, product_name
ORDER BY rname, product_name, season;
