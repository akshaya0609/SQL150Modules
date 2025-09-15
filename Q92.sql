DROP TABLE IF EXISTS competition;
CREATE TABLE competition(
  group_id         INT,
  participant_name VARCHAR(10),
  slice_count      INT,
  bet              INT
);
INSERT INTO competition VALUES
-- group 1
(1,'Alice', 10, 51),
(1,'Bob',   15, 42),
(1,'Eve',   15, 30),
(1,'Tom',    8, 21),
(1,'Jerry', 12, 12),
-- group 2
(2,'Charlie',20, 60),
(2,'David',  20, 72),
(2,'Mike',   20, 54),
(2,'Nancy',  18, 42),
(2,'Oliver', 14, 60),
(2,'Frank',  12, 51);

WITH g AS (                    
  SELECT group_id, MAX(slice_count) AS max_slices
  FROM competition
  GROUP BY group_id
),
winners AS (                        
  SELECT c.group_id, c.participant_name, c.bet
  FROM competition c
  JOIN g ON g.group_id = c.group_id
        AND g.max_slices = c.slice_count
),
win_stats AS (                       
  SELECT group_id, COUNT(*) AS winner_cnt, SUM(bet) AS winner_bet
  FROM winners
  GROUP BY group_id
),
totals AS (                         
  SELECT group_id, SUM(bet) AS total_bet
  FROM competition
  GROUP BY group_id
),
share AS (                            
  SELECT t.group_id,
         0.30 * (t.total_bet - w.winner_bet) / w.winner_cnt AS share_per_winner
  FROM totals t
  JOIN win_stats w ON w.group_id = t.group_id
)
SELECT w.group_id,
       w.participant_name,
       ROUND(w.bet + s.share_per_winner, 2) AS payout
FROM winners w
JOIN share   s ON s.group_id = w.group_id
ORDER BY w.group_id, w.participant_name;