DROP TABLE IF EXISTS viewing_history;
CREATE TABLE viewing_history (
  user_id     INT,
  title       VARCHAR(20),
  device_type VARCHAR(10),
  watch_mins  INT
);
INSERT INTO viewing_history (user_id, title, device_type, watch_mins) VALUES
(1,'Stranger Things','Mobile', 60),
(1,'The Crown',      'Mobile', 45),
(1,'Narcos',         'Smart TV', 90),
(2,'Stranger Things','Mobile', 100),
(2,'The Crown',      'Tablet',  55),
(2,'Narcos',         'Mobile',  95),
(3,'Stranger Things','Mobile', 40),
(3,'The Crown',      'Mobile', 60),
(3,'Narcos',         'Mobile', 70),
(4,'Stranger Things','Mobile', 70),
(4,'The Crown',      'Smart TV', 65),
(4,'Narcos',         'Tablet',   80);


SELECT
    user_id,
    ROUND( 100.0 *
           SUM(CASE WHEN device_type = 'Mobile' THEN watch_mins ELSE 0 END)
           / SUM(watch_mins) ) AS pct_mobile
FROM viewing_history
GROUP BY user_id
HAVING SUM(CASE WHEN device_type = 'Mobile' THEN watch_mins ELSE 0 END)
        >= 0.75 * SUM(watch_mins)
    -- but used at least one non-mobile device
    AND COUNT(DISTINCT CASE WHEN device_type <> 'Mobile' THEN device_type END) >= 1
ORDER BY user_id;
