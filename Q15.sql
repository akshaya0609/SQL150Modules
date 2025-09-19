DROP TABLE IF EXISTS lift_passengers;
DROP TABLE IF EXISTS lifts;
CREATE TABLE lifts (
    id INT PRIMARY KEY,
    capacity_kg INT
);
CREATE TABLE lift_passengers (
    passenger_name VARCHAR(10),
    weight_kg INT,
    lift_id INT,
    FOREIGN KEY (lift_id) REFERENCES lifts(id)
);
INSERT INTO lifts (id, capacity_kg) VALUES
(1, 300),
(2, 350);
INSERT INTO lift_passengers (passenger_name, weight_kg, lift_id) VALUES
('Rahul',   85, 1),
('Adarsh',  73, 1),
('Riti',    95, 1),
('Dheeraj', 80, 1),
('Vimal',   83, 2);

select t.id, group_concat(t.passenger_name order by t.weight_kg) as people
from (
select l.*, p.*, sum(p.weight_kg) over (partition by p.lift_id order by p.weight_kg,p.passenger_name) as weight
from
lifts l join lift_passengers p on l.id=p.lift_id 
) t
where (t.weight)<=t.capacity_kg
group by t.id
order by t.id;