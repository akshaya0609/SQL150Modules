DROP TABLE IF EXISTS Matches;
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    home_team VARCHAR(10),
    away_team VARCHAR(10),
    winner_team VARCHAR(10)
);
INSERT INTO Matches (match_id, home_team, away_team, winner_team) VALUES
(1, 'CSK', 'MI', 'MI'),
(2, 'GL', 'RR', 'GL'),
(3, 'SRH', 'Kings11', 'SRH'),
(4, 'DD', 'KKR', 'KKR'),
(5, 'MI', 'CSK', 'MI'),
(6, 'RR', 'GL', 'GL'),
(7, 'Kings11', 'SRH', 'Kings11'),
(8, 'KKR', 'DD', 'DD');

select t1.home_team as team1, t1.away_team as team2
from matches t1
join matches t2 on t1.home_team=t2.away_team and t1.away_team=t2.home_team
where t1.match_id<t2.match_id and t1.winner_team=t1.away_team and t2.winner_team=t2.away_team;



