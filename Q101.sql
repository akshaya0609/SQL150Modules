DROP TABLE IF EXISTS gmail_data;
CREATE TABLE gmail_data (
  from_user  VARCHAR(20),
  to_user    VARCHAR(20),
  email_day  DATE
);
INSERT INTO gmail_data (from_user, to_user, email_day) VALUES
('a846057933ad01019', '75d295377a46f83236', '2023-11-28'),
('6b503743a13d778200','32ded68d943e8808', '2023-11-29'),
('32ded68d943e8808', '55e60cfcc9dc49c17e','2023-08-20'),
('7e3e9278e23aba2e', 'e0e0defbb69c47f6f7','2023-08-04'),
('11bafadff7d8822864','47be2387766891367e','2023-07-04'),
('40659987dd96796d', '2813e59c0fc1f6908e','2023-04-28'),
('6eedf0be42267d1fa','a846057933ad01019','2023-02-10'),
('c383a0bf7898adf65','55e60cfcc9dc49c17e','2023-11-27'),
('d633836c884aeb9f71d','6b503743a13d778200','2023-11-18'),
('d63386d89443e8808','d633836c884aeb9f71d','2023-01-28'),
('6edf0be42267d1fa',  '5b8754928306a1b868','2023-05-20'),
('5b8754928306a1b868','32ded68d943e8808', '2023-05-22');

WITH sent AS (
  SELECT from_user AS user_id, COUNT(*) AS sent_cnt
  FROM gmail_data
  GROUP BY from_user
),
received AS (
  SELECT to_user   AS user_id, COUNT(*) AS recv_cnt
  FROM gmail_data
  GROUP BY to_user
),
rates AS (
  SELECT s.user_id, s.sent_cnt, r.recv_cnt, CAST(s.sent_cnt AS DECIMAL(18,6)) / r.recv_cnt AS resp_rate
  FROM sent s
  JOIN received r ON r.user_id = s.user_id       
)
SELECT user_id, sent_cnt AS emails_sent, recv_cnt   AS emails_received,
  ROUND(resp_rate * 100, 2) AS response_rate_pct
FROM (
  SELECT rates.*, NTILE(4) OVER (ORDER BY resp_rate DESC) AS quartile
  FROM rates
) q
WHERE quartile = 1                             
ORDER BY resp_rate DESC, user_id;
