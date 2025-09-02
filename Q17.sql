DROP TABLE IF EXISTS business_operations;
CREATE TABLE business_operations (
    business_date DATE NOT NULL,
    city_id       INT  NOT NULL
);
INSERT INTO business_operations (business_date, city_id) VALUES
('2020-01-02', 3),
('2020-07-01', 7),
('2021-01-01', 3),
('2021-02-03', 19),
('2022-12-01', 3),
('2022-12-15', 3),
('2022-02-28', 12);
select year(fdate) as yearr, count(*) as cnt 
from (select city_id,min(business_date) as fdate from business_operations group by city_id) c
group by yearr
order by yearr;