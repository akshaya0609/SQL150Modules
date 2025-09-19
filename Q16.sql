DROP TABLE IF EXISTS lift_psngr;
DROP TABLE IF EXISTS lifts;
CREATE TABLE lifts (
    id INT PRIMARY KEY,
    capacity_kg INT
);
CREATE TABLE lift_psngr (
    passenger_name VARCHAR(10),
    weight_kg INT,
    gender VARCHAR(1),   -- 'F' for female, 'M' for male
    lift_id INT,
    FOREIGN KEY (lift_id) REFERENCES lifts(id)
);
INSERT INTO lifts (id, capacity_kg) VALUES
(1, 300),
(2, 350);
INSERT INTO lift_psngr (passenger_name, weight_kg, gender, lift_id) VALUES
('Rahul',   85, 'M', 1),
('Adarsh',  73, 'M', 1),
('Riti',    95, 'F', 1),
('Dheeraj', 80, 'M', 1),
('Vimal',   83, 'M', 2),
('Sneha',   60, 'F', 2),
('Pooja',   55, 'F', 2);

select t.id, group_concat(t.passenger_name order by case when t.gender='F' then 0 else 1 end,
                          t.weight_kg) as people
from (
select l.*, p.*, 
sum(p.weight_kg) over (partition by p.lift_id 
                       order by case when p.gender='F' then 0 else 1 end,
                       p.weight_kg,p.passenger_name) as weight
from lifts l join lift_psngr p on l.id=p.lift_id 
) t
where (t.weight)<=t.capacity_kg
group by t.id
order by t.id;