DROP TABLE IF EXISTS Notifications;
CREATE TABLE notifications (
  notification_id INT PRIMARY KEY,
  product_id      VARCHAR(2),
  delivered_at    DATETIME
);
INSERT INTO notifications VALUES
(1,'p1','2024-01-01 08:00:00'),
(2,'p2','2024-01-01 10:30:00'),
(3,'p3','2024-01-01 11:30:00');

DROP TABLE IF EXISTS Purchases;
CREATE TABLE purchases (
  user_id            INT,
  product_id         VARCHAR(2),
  purchase_timestamp DATETIME
);

INSERT INTO purchases VALUES
(1,'p1','2024-01-01 09:00:00'),
(2,'p2','2024-01-01 09:00:00'),
(3,'p2','2024-01-01 09:30:00'),
(3,'p1','2024-01-01 10:20:00'),
(4,'p2','2024-01-01 10:40:00'),
(1,'p2','2024-01-01 10:50:00'),
(5,'p2','2024-01-01 11:45:00'),
(2,'p3','2024-01-01 11:45:00'),
(2,'p3','2024-01-01 12:30:00'),
(3,'p3','2024-01-01 14:30:00');

WITH cte AS (
SELECT *,
CASE WHEN DATE_ADD(delivered_at, INTERVAL 2 HOUR) <= LEAD(delivered_at, 1, '9999-12-31') OVER (ORDER BY notification_id) THEN DATE_ADD(delivered_at, INTERVAL 2 HOUR) -- Calculate valid notification end time as 2 hours after delivery if earlier than next notification

ELSE LEAD(delivered_at, 1, '9999-12-31') OVER (ORDER BY notification_id) -- Otherwise use next notification's delivered_at timestamp
END AS notification_valid_till
FROM notifications
),
cte2 AS (
SELECT
notification_id, p.user_id,
p.product_id AS purchased_product,
cte.product_id AS notified_product
FROM purchases p
INNER JOIN cte ON p.purchase_timestamp BETWEEN delivered_at AND notification_valid_till -- Join purchases made during notification validity period
)
SELECT
notification_id,
SUM(CASE WHEN purchased_product = notified_product THEN 1 ELSE 0 END) AS same_product_purchases
,SUM(CASE WHEN purchased_product != notified_product THEN 1 ELSE 0 END) AS different_product_purchases -- Count purchases of different products
FROM cte2
GROUP BY notification_id -- Aggregate counts per notification
ORDER BY notification_id;