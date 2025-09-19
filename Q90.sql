DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
  transaction_id   INT PRIMARY KEY,
  customer_id      INT,
  transaction_date DATE,
  amount           INT
);
DROP TABLE IF EXISTS interestrates;
CREATE TABLE interestrates (
  rate_id       INT PRIMARY KEY,
  min_balance   INT,
  max_balance   INT,
  interest_rate DECIMAL(5,4)  -- per day
);
INSERT INTO transactions (transaction_id, customer_id, transaction_date, amount) VALUES
  (1, 1, '2024-03-01', 1000),
  (2, 2, '2024-03-02',  500),
  (3, 3, '2024-03-03', 1500),
  (4, 1, '2024-03-15', -300),
  (5, 2, '2024-03-20',  700),
  (6, 3, '2024-03-25', -200),
  (7, 1, '2024-03-28',  400);

INSERT INTO interestrates (rate_id, min_balance, max_balance, interest_rate) VALUES
  (1,   0,   499, 0.0100),
  (2, 500,   999, 0.0200),
  (3,1000,  1499, 0.0300),
  (4,1500, 99999, 0.0400);

with cte as (
SELECT
customer_id,
transaction_date,
SUM(sum(amount)) OVER (PARTITION BY customer_id ORDER BY transaction_date) AS net_amount
FROM transactions
group by customer_id,transaction_date),
cte2 AS (
SELECT
customer_id,
transaction_date,
net_amount,
LEAD(transaction_date, 1, '2024-04-01') OVER (PARTITION BY customer_id ORDER BY transaction_date) AS next_trans_date
FROM cte
)
SELECT
cte2.customer_id,
SUM(
DATEDIFF(next_trans_date, transaction_date) * net_amount * ir.interest_rate
) AS interest_earned
FROM cte2
INNER JOIN InterestRates ir
ON cte2.net_amount BETWEEN ir.min_balance AND ir.max_balance
GROUP BY cte2.customer_id
ORDER BY cte2.customer_id;
