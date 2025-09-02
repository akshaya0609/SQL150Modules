DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers (
    id         VARCHAR(10),
    start_loc  VARCHAR(1),
    start_time TIME,
    end_loc    VARCHAR(1),
    end_time   TIME
);
INSERT INTO drivers (id, start_time, end_time, start_loc, end_loc) VALUES
('dri_1', '09:00:00', '09:30:00', 'a', 'b'),
('dri_1', '09:30:00', '10:30:00', 'b', 'c'),
('dri_1', '11:00:00', '11:30:00', 'd', 'e'),
('dri_1', '12:00:00', '12:30:00', 'f', 'g'),
('dri_1', '13:30:00', '14:30:00', 'c', 'h'),
('dri_2', '12:15:00', '12:30:00', 'f', 'g'),
('dri_2', '12:30:00', '14:30:00', 'c', 'h');

select d1.id, count(*) as total_rides, 
sum(case when d1.start_time=d2.end_time and d1.start_loc=d2.end_loc then 1 else 0 end)
from drivers d1
left join drivers d2 on d1.id=d2.id and d1.start_time=d2.end_time and d1.start_time=d2.end_time
group by d1.id
order by d1.id;  

select id, count(*) as total_rides,
sum(profit) as profit_rides 
from (select drivers.*, 
       (case when start_time=lag(end_time) over (partition by id order by start_time) 
     and start_loc=lag(end_loc) over (partition by id order by start_time) then 1 else 0 end) as profit
from drivers) as d
group by id
order by id;