DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
    team_id INT,
    team_name VARCHAR(50)
);
INSERT INTO teams VALUES
(10, 'Give'),
(20, 'Never'),
(30, 'You'),
(40, 'Up'),
(50, 'Gonna');
DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
    match_id INT,
    host_team INT,
    guest_team INT,
    host_goals INT,
    guest_goals INT
);
INSERT INTO matches VALUES
(1, 30, 20, 1, 0),
(2, 10, 20, 1, 2),
(3, 20, 50, 2, 2),
(4, 10, 30, 1, 0),
(5, 30, 50, 0, 1);

SELECT t.team_id, t.team_name,
SUM(CASE WHEN t.team_id = m.host_team AND m.host_goals > m.guest_goals THEN 3
	WHEN t.team_id = m.guest_team AND m.guest_goals > m.host_goals THEN 3
	WHEN (t.team_id = m.host_team OR t.team_id = m.guest_team) 
		  AND m.host_goals = m.guest_goals THEN 1
	ELSE 0
	END
    ) AS num_points
FROM teams t
LEFT JOIN matches m ON t.team_id IN (m.host_team, m.guest_team)
GROUP BY t.team_id, t.team_name
ORDER BY num_points DESC, t.team_id ASC;