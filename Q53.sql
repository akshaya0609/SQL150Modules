DROP TABLE IF EXISTS post_likes;
DROP TABLE IF EXISTS user_follows;
CREATE TABLE post_likes (
  post_id INT,
  user_id INT
);
INSERT INTO post_likes (user_id, post_id) VALUES
(1,100),
(2,100),
(3,200),
(4,300),
(5,300),
(1,300);
CREATE TABLE user_follows (
  user_id INT,           -- follower
  follows_user_id INT    -- followee
);
INSERT INTO user_follows VALUES
(1,2),
(1,3),
(1,4),
(2,1),
(2,3);

WITH followees AS (                      -- who each user follows
  SELECT user_id, follows_user_id
  FROM user_follows
),
likes AS (                               -- post likes (who liked what)
  SELECT user_id, post_id
  FROM post_likes
),
candidate_counts AS (                    -- how many followees liked each post
  SELECT
    f.user_id,
    l.post_id,
    COUNT(*) AS like_count              -- number of followed users who liked the post
  FROM followees f
  JOIN likes l
    ON l.user_id = f.follows_user_id
  GROUP BY f.user_id, l.post_id
),
exclude_own_likes AS (                   -- remove posts already liked by the user
  SELECT c.*
  FROM candidate_counts c
  LEFT JOIN likes me
    ON me.user_id = c.user_id AND me.post_id = c.post_id
  WHERE me.user_id IS NULL
),
ranked AS (                              -- pick best post per user
  SELECT
    user_id, post_id, like_count,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY like_count DESC, post_id ASC
    ) AS rn
  FROM exclude_own_likes
)
SELECT user_id, post_id, like_count
FROM ranked
WHERE rn = 1
ORDER BY user_id;									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
