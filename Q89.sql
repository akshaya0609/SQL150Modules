DROP TABLE IF EXISTS viewing_history;
CREATE TABLE viewing_history(
  user_id     INT,
  title       VARCHAR(20),
  device_type VARCHAR(10)
);

INSERT INTO viewing_history (user_id, title, device_type) VALUES
-- user 1
(1,'Stranger Things','Mobile'),
(1,'Stranger Things','Smart TV'),
(1,'The Crown','Mobile'),
(1,'Narcos','Smart TV'),
-- user 2
(2,'Stranger Things','Mobile'),
(2,'Stranger Things','Tablet'),
(2,'The Crown','Tablet'),
(2,'Narcos','Mobile'),
(2,'Narcos','Smart TV'),
-- user 3
(3,'Stranger Things','Mobile'),
(3,'The Crown','Mobile'),
(3,'Narcos','Mobile'),
-- user 4
(4,'Stranger Things','Mobile'),
(4,'Stranger Things','Smart TV'),
(4,'The Crown','Smart TV');

WITH per_title AS (        
  SELECT user_id, title,
         COUNT(DISTINCT device_type) AS device_ct
  FROM viewing_history
  GROUP BY user_id, title
),
agg AS (                  
  SELECT user_id,
         SUM(CASE WHEN device_ct > 1 THEN 1 ELSE 0 END) AS titles_multi_devices,
         SUM(CASE WHEN device_ct = 1 THEN 1 ELSE 0 END) AS titles_single_device
  FROM per_title
  GROUP BY user_id
)
SELECT user_id,
       titles_multi_devices,
       titles_single_device
FROM agg
WHERE titles_multi_devices > titles_single_device
ORDER BY user_id;
