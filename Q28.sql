DROP TABLE IF EXISTS malware;
CREATE TABLE malware (
  software_id      INT        NOT NULL,
  run_date         DATETIME   NOT NULL,
  malware_detected INT        NOT NULL,
  PRIMARY KEY (software_id, run_date)
);
INSERT INTO malware (software_id, run_date, malware_detected) VALUES
-- software 100 (3 runs; latest < 10 so it will be excluded in the final query)
(100, '2024-01-01 02:00:01', 12),
(100, '2024-01-01 03:12:01', 15),
(100, '2024-01-01 16:00:01',  9),
-- software 101 (3 runs; latest >= 10)
(101, '2024-01-01 12:00:00',  9),
(101, '2024-01-01 16:00:00',  9),
(101, '2024-01-01 18:00:00', 12),
-- software 102 (2 runs; latest >= 10)
(102, '2024-01-01 14:00:00', 14),
(102, '2024-01-01 14:10:00', 13),
-- software 103 (2 runs; latest >= 10)
(103, '2024-01-01 15:00:00', 11),
(103, '2024-01-01 17:00:00', 16),
-- software 104 (only one run; will be excluded)
(104, '2024-01-01 18:30:00',  8);
select software_id,max(run_date), malware_detected as latest from malware
group by software_id;

with cte as(
select software_id, malware_detected as latest,
lead(malware_detected) over (partition by software_id order by run_date desc) as previous,
row_number() over (partition by software_id order by run_date desc)as rn,
count(*) over (partition by software_id) as cnt from malware
) 
select software_id, latest, latest-previous as difference from cte
where rn=1 and cnt>=2 and latest>=10 
order by software_id;
