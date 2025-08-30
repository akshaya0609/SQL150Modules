DROP TABLE IF EXISTS sachin;
CREATE TABLE sachin (
    match_no INT PRIMARY KEY,
    runs_scored INT,
    status VARCHAR(10)   -- 'out' or 'notout'
);
INSERT INTO sachin (match_no, runs_scored, status) VALUES
(1, 34, 'out'),
(2, 56, 'out'),
(3, 78, 'notout'),
(4, 12, 'out'),
(5, 100, 'out'),
(6, 45, 'out'),
(7, 89, 'notout'),
(8, 66, 'out'),
(9, 55, 'out'),
(10, 90, 'out');

SELECT round(match_no,2) as match_numbr
FROM sachin s1
WHERE (
    SELECT SUM(runs_scored)
    FROM sachin s2
    WHERE s2.match_no <= s1.match_no
) >= 500
ORDER BY match_no;