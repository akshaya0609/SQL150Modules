DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  customer_id    INT,
  product_name   VARCHAR(20),
  transaction_timestamp DATETIME,
  country        VARCHAR(10)
);
-- Sample data
INSERT INTO transactions (transaction_id, customer_id, product_name, transaction_timestamp, country) VALUES
(1 , 101, 'Laptop'     , '2024-01-01 08:00:00', 'India'),
(2 , 101, 'Laptop Bag' , '2024-01-01 08:15:00', 'India'),
(3 , 102, 'Mouse'      , '2024-01-02 12:00:00', 'India'),
(4 , 102, 'Tablet'     , '2024-01-02 18:00:00', 'India'),
(5 , 101, 'Laptop'     , '2024-01-04 14:00:00', 'India'),
(6 , 102, 'Laptop'     , '2024-01-04 14:08:00', 'India'),
(7 , 102, 'Laptop Bag' , '2024-01-06 15:00:00', 'India'),
(8 , 103, 'Smartphone' , '2024-01-06 16:00:00', 'India'),
(9 , 103, 'Laptop Bag' , '2024-01-07 09:00:00', 'USA'),
(10, 201, 'Keyboard'   , '2024-01-07 09:05:00', 'USA'),
(11, 201, 'Laptop'     , '2024-01-07 09:15:00', 'USA');

SELECT c.country,
    (SELECT COUNT(DISTINCT t.customer_id)
      FROM transactions t
      WHERE t.product_name = 'Laptop'
        AND t.country = c.country) AS laptop_customers,
    (SELECT COUNT(DISTINCT l.customer_id)
      FROM transactions l
      WHERE l.product_name = 'Laptop'
        AND l.country = c.country
        AND EXISTS (
              SELECT 1
              FROM transactions b
              WHERE b.customer_id = l.customer_id
                AND b.country = l.country
                AND b.product_name = 'Laptop Bag'
                AND b.transaction_timestamp > l.transaction_timestamp
                AND NOT EXISTS (
                      SELECT 1
                      FROM transactions x
                      WHERE x.customer_id = l.customer_id
                        AND x.transaction_timestamp > l.transaction_timestamp
                        AND x.transaction_timestamp < b.transaction_timestamp))
    ) AS bag_after_laptop_customers FROM ( SELECT DISTINCT country FROM transactions ) c
ORDER BY c.country;
