DROP TABLE IF EXISTS purchase_history;
CREATE TABLE purchase_history(
  userid       INT,
  productid    INT,
  purchasedate DATE
);

INSERT INTO purchase_history VALUES
-- user 1
(1,1,'2012-01-23'),
(1,1,'2012-01-23'),      -- same product on same day (OK)
(1,2,'2012-01-23'),
(1,3,'2012-01-25'),
-- user 2
(2,1,'2012-01-23'),
(2,2,'2012-01-23'),
(2,2,'2012-01-25'),      -- same product on different day (disqualify)
(2,4,'2012-01-25'),
-- user 3
(3,4,'2012-01-23'),
(3,1,'2012-01-23');      -- only one distinct date (disqualify)

WITH per_prod_dates AS (             
  SELECT userid, productid,
         COUNT(DISTINCT purchasedate) AS date_cnt
  FROM purchase_history
  GROUP BY userid, productid
),
bad_users AS (                       
  SELECT DISTINCT userid
  FROM per_prod_dates
  WHERE date_cnt > 1
),
user_stats AS (                      
  SELECT userid,
         COUNT(DISTINCT purchasedate) AS distinct_dates,
         COUNT(DISTINCT productid)    AS product_cnt
  FROM purchase_history
  GROUP BY userid
)
SELECT u.userid, u.product_cnt
FROM user_stats u
LEFT JOIN bad_users b ON b.userid = u.userid
WHERE b.userid IS NULL            
  AND u.distinct_dates >= 2        
ORDER BY u.userid;
