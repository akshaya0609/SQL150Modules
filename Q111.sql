DROP TABLE IF EXISTS hierarchy;
CREATE TABLE hierarchy (
  e_id VARCHAR(1),
  m_id VARCHAR(1)
);
INSERT INTO hierarchy (e_id, m_id) VALUES
('A','C'),
('B','C'),
('C','F'),
('D','E'),
('E','F'),
('G','E'),
('H','G'),
('I','F'),
('J','I'),
('K','I');

WITH RECURSIVE chain AS (
  SELECT e_id, m_id, m_id AS root
  FROM hierarchy
  UNION ALL
  SELECT h.e_id, h.m_id, c.root
  FROM hierarchy h
  JOIN chain c
    ON h.m_id = c.e_id
)
SELECT
  root AS m_id,
  COUNT(DISTINCT e_id) AS num_of_reportees
FROM chain
GROUP BY root
ORDER BY num_of_reportees DESC;
