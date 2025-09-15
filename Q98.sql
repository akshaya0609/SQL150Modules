CREATE TABLE credit_card_transactions (
  transaction_id   INT PRIMARY KEY,
  city             VARCHAR(10),
  transaction_date DATE,
  card_type        VARCHAR(12),
  gender           VARCHAR(1),
  amount           INT
);
INSERT INTO credit_card_transactions VALUES
( 1,'Delhi'    ,'2024-01-13','Gold'    ,'F', 500),
( 2,'Bengaluru','2024-01-13','Silver'  ,'M',1000),
( 3,'Mumbai'   ,'2024-01-14','Silver'  ,'F',1200),
( 4,'Bengaluru','2024-01-14','Gold'    ,'M', 900),
( 5,'Bengaluru','2024-01-14','Gold'    ,'F', 300),
( 6,'Delhi'    ,'2024-01-15','Silver'  ,'M', 200),
( 7,'Mumbai'   ,'2024-01-15','Gold'    ,'F', 900),
( 8,'Delhi'    ,'2024-01-15','Gold'    ,'F', 300),
( 9,'Mumbai'   ,'2024-01-15','Silver'  ,'F', 150),
(10,'Mumbai'   ,'2024-01-16','Platinum','F',1900),
(11,'Bengaluru','2024-01-16','Platinum','M',1250);

WITH spend AS (
  SELECT city, card_type, SUM(amount) AS total_amt
  FROM credit_card_transactions
  GROUP BY city, card_type
),
ranked AS (
  SELECT
    city,
    card_type,
    total_amt,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_amt DESC, card_type) AS r_max,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_amt ASC,  card_type) AS r_min
  FROM spend
)
SELECT
  city,
  MAX(CASE WHEN r_max = 1 THEN card_type END) AS highest_spend_card_type,
  MAX(CASE WHEN r_max = 1 THEN total_amt END) AS highest_spend_amount,
  MAX(CASE WHEN r_min = 1 THEN card_type END) AS lowest_spend_card_type,
  MAX(CASE WHEN r_min = 1 THEN total_amt END) AS lowest_spend_amount
FROM ranked
GROUP BY city
ORDER BY city;