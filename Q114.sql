DROP TABLE IF EXISTS players;
CREATE TABLE players(
  player_id INT PRIMARY KEY,
  group_id  INT
);
INSERT INTO players VALUES
(1,1),(2,1),(3,1),(4,1),
(5,2),(6,2),(7,2),(8,2),(9,2),
(10,3),(11,3),(12,3);
DROP TABLE IF EXISTS matches;
CREATE TABLE matches(
  match_id      INT PRIMARY KEY,
  first_player  INT,
  second_player INT,
  first_score   INT,
  second_score  INT
);
INSERT INTO matches VALUES
(1, 1,2, 3,1),
(2, 3,4, 2,2),
(3, 1,3, 0,2),
(4, 2,4, 1,2),
(5, 1,4, 3,0);
INSERT INTO matches VALUES
(6, 5,6, 1,1),
(7, 7,8, 2,2),
(8, 5,7, 2,1),
(9, 6,9, 0,3),
(10,8,9, 1,2);
INSERT INTO matches VALUES
(11,10,11, 1,3),
(12,11,12, 2,2),
(13,10,12, 0,1);

SELECT group_id, player_id AS winner_id FROM (
SELECT p.group_id, p.player_id, 
COALESCE(SUM(CASE WHEN m.first_player  = p.player_id THEN m.first_score
              WHEN m.second_player = p.player_id THEN m.second_score
              ELSE 0 END),0) AS total_points,
ROW_NUMBER() OVER (PARTITION BY p.group_id ORDER BY COALESCE(SUM(
                     CASE
                       WHEN m.first_player  = p.player_id THEN m.first_score
                       WHEN m.second_player = p.player_id THEN m.second_score
                       ELSE 0
                     END),0) DESC,
p.player_id DESC) AS rn
FROM players p LEFT JOIN matches m ON m.first_player = p.player_id OR m.second_player = p.player_id
GROUP BY p.group_id, p.player_id
) t
WHERE rn = 1
ORDER BY group_id;