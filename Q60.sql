DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS influencers;
CREATE TABLE influencers (
  influencer_id INT PRIMARY KEY,
  username      VARCHAR(10),
  join_date     DATE
);
INSERT INTO influencers (influencer_id, username, join_date) VALUES
(1, 'Ankit',  '2023-02-01'),
(2, 'Rahul',  '2023-03-05'),
(3, 'Suresh', '2023-05-20');
CREATE TABLE posts (
  post_id        INT PRIMARY KEY,
  influencer_id  INT,
  post_date      DATE,
  likes          INT,
  comments       INT,
  FOREIGN KEY (influencer_id) REFERENCES influencers(influencer_id)
);

INSERT INTO posts (post_id, influencer_id, post_date, likes, comments) VALUES
-- influencer 1
(1, 1, '2023-01-05', 100, 20),
(2, 1, '2023-01-10', 150, 30),
(3, 1, '2023-02-05', 200, 45),
(4, 1, '2023-02-10', 120, 25),
-- influencer 2
(5, 2, '2023-02-15', 150, 30),
(6, 2, '2023-02-20', 200, 25),
(7, 2, '2023-03-10', 250, 15),
(8, 2, '2023-03-15', 200, 35);




WITH p AS (
  SELECT
    influencer_id,
    post_date,
    (likes + comments) AS eng
  FROM posts
)
SELECT
  i.influencer_id,
  i.username,
  ROUND(
    (
      AVG(CASE WHEN p.post_date >= i.join_date THEN p.eng END) -
      AVG(CASE WHEN p.post_date <  i.join_date THEN p.eng END)
    )
    / AVG(CASE WHEN p.post_date < i.join_date THEN p.eng END) * 100, 2
  ) AS growth_rate_pct
FROM influencers i
LEFT JOIN p
  ON p.influencer_id = i.influencer_id
GROUP BY i.influencer_id, i.username
HAVING
  COUNT(CASE WHEN p.post_date <  i.join_date THEN 1 END) > 0   -- must have before posts
  AND COUNT(CASE WHEN p.post_date >= i.join_date THEN 1 END) > 0   -- and after posts
ORDER BY growth_rate_pct DESC;