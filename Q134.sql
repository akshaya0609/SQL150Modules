DROP TABLE IF EXISTS users;
CREATE TABLE users (
  user_id INT,
  uname VARCHAR(50),
  email VARCHAR(100),
  signup_date DATE
);
INSERT INTO users (user_id, uname, email, signup_date) VALUES
(1, 'John Doe', 'john@example.com', '2025-05-10'),
(2, 'Jane Smith', 'jane@example.com', '2024-11-25'),
(3, 'Alice Johnson', 'alice@example.com', '2024-10-16'),
(4, 'Bob Brown', 'bob@example.com', '2024-08-17'),
(5, 'Sania', 'sania@example.com', '2024-11-05'),
(6, 'Rohit', 'rohit@example.com', '2025-05-14');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id INT,
  user_id INT,
  order_date DATE,
  order_amount INT
);
INSERT INTO orders (order_id, user_id, order_date, order_amount) VALUES
(1, 1, '2025-05-14', 150),
(2, 2, '2025-05-24', 130),
(3, 2, '2025-03-28', 145),
(4, 3, '2025-02-28', 160),
(5, 4, '2025-02-23', 125),
(6, 4, '2025-02-21', 105);

SELECT u.user_id, u.uname, u.email, IFNULL(o.last_order_amount, 0) AS last_order_amount
FROM users u
LEFT JOIN (
SELECT o1.user_id, o1.order_amount AS last_order_amount, o1.order_date FROM orders o1
WHERE o1.order_date = (SELECT MAX(o2.order_date) FROM orders o2 WHERE o2.user_id = o1.user_id)
) o ON u.user_id = o.user_id
WHERE u.signup_date <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)  -- registered > 6 months ago
  AND (o.order_date IS NULL   -- never ordered 
       OR o.order_date < DATE_SUB(CURDATE(), INTERVAL 3 MONTH) -- last order older than 3 months
      )
ORDER BY u.user_id;