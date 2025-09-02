DROP TABLE IF EXISTS driver_ratings;
CREATE TABLE driver_ratings (
  driver_id   INT PRIMARY KEY,
  avg_rating  DECIMAL(3,2)
);
INSERT INTO driver_ratings (driver_id, avg_rating) VALUES
(1,  4.80),
(2,  4.50),
(3,  3.90),
(4,  4.10),
(5,  4.70),
(6,  3.60),
(7,  4.90),
(8,  3.80),
(9,  4.40),
(10, 3.50),
(11, 4.10);

select driver_id, avg_rating,
case when NTILE(3) over (order by avg_rating desc) =1 then 'Top'
     when NTILE(3) over (order by avg_rating desc) = 2 then 'Middle'
     when NTILE(3) over (order by avg_rating desc) =3 then 'Bottom' end as performance
from driver_ratings;
