DROP TABLE IF EXISTS assessments;
CREATE TABLE assessments (
  candidate_id INT,
  experience   INT,
  sql_score    INT,
  algo         INT,
  bug_fixing   INT
);
INSERT INTO assessments (candidate_id, experience, sql_score, algo, bug_fixing) VALUES
(1, 3, 100, NULL,  50),
(2, 5, NULL, 100, 100),
(3, 1, 100, 100, 100),
(4, 5, 100,  50, 100),
(5, 1,  50, NULL, NULL),
(6, 3,  50, NULL, NULL),
(7, 4, 100, NULL, NULL),
(8, 6, 100, NULL, NULL),
(9, 5, 100, 100, NULL),
(10, 2, 100, NULL, 100);

SELECT experience, COUNT(*) AS total_candidates,
SUM(CASE WHEN ( (sql_score = 100 OR sql_score IS NULL) AND (algo = 100 OR algo IS NULL)
           AND (bug_fixing = 100 OR bug_fixing IS NULL))
	THEN 1 ELSE 0 END) AS perfect_score_count
FROM assessments
GROUP BY experience
ORDER BY experience;