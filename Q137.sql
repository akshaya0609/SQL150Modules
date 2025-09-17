DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INT,
    customer_id INT,
    transaction_date DATE,
    amount INT
);
INSERT INTO transactions VALUES
(1, 1, '2025-01-13', 100),
(2, 5, '2025-02-13', 200),
(3, 7, '2025-03-13', 180),
(4, 1, '2025-03-13', 150),
(5, 3, '2024-12-01', 120),
(6, 4, '2025-02-05', 130),
(7, 6, '2025-02-19', 200),
(8, 2, '2025-03-01', 110),
(9, 6, '2025-03-03', 190),
(10, 2, '2025-02-01', 90),
(11, 7, '2025-03-13', 150),
(12, 7, '2025-05-13', 180);

WITH first_purchase AS (
SELECT customer_id, MIN(transaction_date) AS first_purchase_date
FROM transactions
GROUP BY customer_id
)
SELECT customer_id, first_purchase_date
FROM first_purchase
WHERE first_purchase_date BETWEEN '2024-12-01' AND '2025-02-28'
ORDER BY customer_id;