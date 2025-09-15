DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS holidays;
CREATE TABLE orders (
  order_id   INT,
  order_date DATE,
  ship_date  DATE
);
INSERT INTO orders VALUES
(1,'2024-03-14','2024-03-20'),
(2,'2024-03-10','2024-03-16'),
(3,'2024-03-04','2024-03-12'),
(4,'2024-03-05','2024-03-07'),
(5,'2024-03-03','2024-03-08'),
(6,'2024-03-07','2024-03-24');
CREATE TABLE holidays (
  holiday_id   INT,
  holiday_date DATE
);
INSERT INTO holidays VALUES
(1,'2024-03-10'),
(2,'2024-03-18'),
(3,'2024-03-21');

WITH adj AS (   -- weekend adjustments
  SELECT
    o.order_id,
    CASE DAYOFWEEK(o.order_date)          -- 1=Sunday, 7=Saturday
      WHEN 1 THEN DATE_ADD(o.order_date, INTERVAL 1 DAY)  -- Sun -> Mon
      WHEN 7 THEN DATE_ADD(o.order_date, INTERVAL 2 DAY)  -- Sat -> Mon
      ELSE o.order_date
    END AS order_dt,

    CASE DAYOFWEEK(o.ship_date)
      WHEN 1 THEN DATE_ADD(o.ship_date, INTERVAL -2 DAY)  -- Sun -> Fri
      WHEN 7 THEN DATE_ADD(o.ship_date, INTERVAL -1 DAY)  -- Sat -> Fri
      ELSE o.ship_date
    END AS ship_dt
  FROM orders o
),
adj_with_h AS (   -- holidays strictly between the adjusted dates
  SELECT
    a.*,
    ( SELECT COUNT(*)
      FROM holidays h
      WHERE h.holiday_date > a.order_dt
        AND h.holiday_date < a.ship_dt
    ) AS holiday_cnt
  FROM adj a
)
SELECT
  order_id,
  order_dt   AS adjusted_order_date,
  ship_dt    AS adjusted_ship_date,
  holiday_cnt AS holidays_excluded,
  DATEDIFF(ship_dt, order_dt) - holiday_cnt AS lead_days
FROM adj_with_h
ORDER BY order_id;
