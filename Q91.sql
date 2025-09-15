DROP TABLE IF EXISTS elections;
CREATE TABLE elections(
  district_name  varchar(20),
  candidate_id   int,
  party_name     varchar(10),
  votes          int
);

INSERT INTO elections VALUES
('Delhi North',   101,'Congress',1500),
('Delhi North',   102,'BJP',     1500),
('Delhi North',   103,'AAP',     1100),
('Mumbai South',  106,'Congress',2000),
('Mumbai South',  107,'BJP',     1800),
('Mumbai South',  110,'AAP',     1500),
('Kolkata East',  113,'Congress',2200),
('Kolkata East',  114,'AAP',     2000),
('Kolkata East',  115,'BJP',     1400),
('Chennai Central',116,'Congress',1600),
('Chennai Central',117,'BJP',     1700);

WITH winners AS (
  SELECT e.district_name, e.party_name
  FROM elections e
  JOIN ( SELECT district_name, MAX(votes) AS mx
         FROM elections
         GROUP BY district_name ) m
    ON m.district_name = e.district_name AND m.mx = e.votes
),
seats_per_party AS (
  SELECT party_name, COUNT(*) AS seats
  FROM winners
  GROUP BY party_name
),
total_seats AS (
  SELECT COUNT(DISTINCT district_name) AS total
  FROM elections
)
SELECT s.party_name,
       s.seats,
       CASE WHEN s.seats > t.total/2 THEN 'Winner' ELSE 'Loser' END AS result
FROM seats_per_party s
CROSS JOIN total_seats t
ORDER BY s.seats DESC, s.party_name;