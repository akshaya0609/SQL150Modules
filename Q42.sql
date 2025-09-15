DROP TABLE IF EXISTS icc_world_cup;
CREATE TABLE icc_world_cup (
  team_1  VARCHAR(10),
  team_2  VARCHAR(10),
  winner  VARCHAR(10)   -- 'Draw' when match is tied
);
INSERT INTO icc_world_cup (team_1, team_2, winner) VALUES
('India', 'SL',   'India'),
('SL',    'Aus',  'Draw'),
('SA',    'Eng',  'Eng'),
('Eng',   'NZ',   'NZ'),
('Aus',   'India','India'),
('Eng',   'SA',   'Draw');

/* select team_name, count(*) as matches_no, sum(win) as wins, sum(loss) as losses, 
sum(points) as points
from (select team_1 as team_name, winner=team_1 as win,
(winner<> team_2 and winner<>'Draw') as loss
(case when winner=team_1 then 2 when winner='Draw' then 1 else 0 end) as points 
from icc_world_cup 
union all 
select team_2 as team_name, winner=team_2 as win,
(winner<> team_1 and winner<>'Draw') as loss
(case when winner=team_2 then 2 when winner='Draw' then 1 else 0 end) as points 
from icc_world_cup) t
group by team_name
order by team_name; */ -- wrong

select team_name, count(*) as matches_played,
sum(case when result='win' then 1 else 0 end) as wins,
sum(case when result='Loss' then 1 else 0 end) as losses,
sum(case when result='win' then 2 when result='Draw' then 1 else 0 end) as points
from(
select team_1 as team_name, 
(case when winner=team_1 then 'win' when winner='Draw' then 'Draw' else 'Loss' end) as result
from icc_world_cup 
union all 
select team_2 as team_name, 
(case when winner=team_2 then 'win' when winner='Draw' then 'Draw' else 'Loss' end) as result
from icc_world_cup) t
group by team_name order by team_name;