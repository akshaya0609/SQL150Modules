DROP TABLE IF EXISTS team;
CREATE TABLE team (
  id    INT PRIMARY KEY,
  name  VARCHAR(20) NOT NULL,
  coach VARCHAR(20) NOT NULL
);
INSERT INTO team (id, name, coach) VALUES
(1, 'Mumbai FC',     'Sunil Chhetri'),
(2, 'Delhi Dynamos', 'Sandesh Jhingan'),
(3, 'Bengaluru FC',  'Gurpreet Singh'),
(4, 'Goa FC',        'Brandon Fernandes');

DROP TABLE IF EXISTS game;
CREATE TABLE game (
  match_id   INT PRIMARY KEY,
  match_date DATE NOT NULL,
  stadium    VARCHAR(20) NOT NULL,
  team1      INT NOT NULL,
  team2      INT NOT NULL,
  CONSTRAINT fk_game_team1 FOREIGN KEY (team1) REFERENCES team(id),
  CONSTRAINT fk_game_team2 FOREIGN KEY (team2) REFERENCES team(id)
);

INSERT INTO game (match_id, match_date, stadium, team1, team2) VALUES
(1, '2024-09-01', 'Wankhede',          1, 2),
(2, '2024-09-02', 'Jawaharlal Nehru',  3, 4),
(3, '2024-09-03', 'Sree Kanteerava',   1, 3),
(4, '2024-09-04', 'Wankhede',          1, 4);

-- 3) Goals
DROP TABLE IF EXISTS goal;
CREATE TABLE goal (
  match_id  INT NOT NULL,
  team_id   INT NOT NULL,
  player    VARCHAR(20) NOT NULL,
  goal_time TIME NOT NULL,
  CONSTRAINT fk_goal_match FOREIGN KEY (match_id) REFERENCES game(match_id),
  CONSTRAINT fk_goal_team  FOREIGN KEY (team_id)  REFERENCES team(id)
);

INSERT INTO goal (match_id, team_id, player, goal_time) VALUES
(1, 1, 'Anirudh Thapa',    '18:23:00'),
(1, 1, 'Sunil Chhetri',    '67:12:00'),
(2, 3, 'Udanta Singh',     '22:45:00'),
(2, 4, 'Ferran Corominas', '55:21:00'),
(2, 3, 'Sunil Chhetri',    '78:34:00'),
(3, 1, 'Bipin Singh',      '11:08:00'),
(3, 3, 'Cleiton Silva',    '41:20:00'),
(3, 1, 'Sunil Chhetri',    '59:45:00'),
(3, 3, 'Cleiton Silva',    '62:56:00');

-- match_id, match_date, team1, score1, team2, score2
select g.match_id, g.match_date, t1.name as team1, t2.name as team2, 
sum(case when go.team_id=g.team1 then 1 else 0 end) as score1, 
sum(case when go.team_id=g.team2 then 1 else 0 end) as score2
from game g 
left join goal go using (match_id)
join team t1 on t1.id=g.team1
join team t2 on t2.id=g.team2
group by g.match_id, g.match_date, team1, team2;