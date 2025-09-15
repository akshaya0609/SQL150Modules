DROP TABLE IF EXISTS country_data;
CREATE TABLE country_data (
  country_name    VARCHAR(15),
  indicator_name  VARCHAR(25),
  year_2010       DECIMAL(3,2),
  year_2011       DECIMAL(3,2),
  year_2012       DECIMAL(3,2),
  year_2013       DECIMAL(3,2),
  year_2014       DECIMAL(3,2)
);
-- United States
INSERT INTO country_data
(country_name, indicator_name, year_2010, year_2011, year_2012, year_2013, year_2014) VALUES
('United States','Control of Corruption',     1.26, 1.51, 1.52, 1.49, 1.55),
('United States','Government Effectiveness',  1.27, 1.45, 1.28, 1.35, 1.38),
('United States','Regulatory Quality',        1.28, 1.63, 1.63, 1.60, 1.58),
('United States','Rule of Law',               1.32, 1.61, 1.60, 1.59, 1.62),
('United States','Voice and Accountability',  1.30, 1.11, 1.13, 1.15, 1.18),
-- Canada
('Canada','Control of Corruption',            1.46, 1.61, 1.71, 1.70, 1.68),
('Canada','Government Effectiveness',         1.47, 1.55, 1.38, 1.44, 1.46),
('Canada','Regulatory Quality',               1.38, 1.73, 1.63, 1.62, 1.65),
('Canada','Rule of Law',                      1.42, 1.71, 1.80, 1.78, 1.76),
('Canada','Voice and Accountability',         1.40, 1.19, 1.21, 1.20, 1.25);

WITH unpvt AS (
  SELECT country_name, indicator_name, 2010 AS yr, year_2010 AS val FROM country_data
  UNION ALL
  SELECT country_name, indicator_name, 2011 as yr, year_2011 FROM country_data
  UNION ALL
  SELECT country_name, indicator_name, 2012 as yr, year_2012 FROM country_data
  UNION ALL
  SELECT country_name, indicator_name, 2013 as yr, year_2013 FROM country_data
  UNION ALL
  SELECT country_name, indicator_name, 2014 as yr, year_2014 FROM country_data
),
rnk AS (
  SELECT
    country_name, indicator_name, yr, val,
    ROW_NUMBER() OVER (
      PARTITION BY country_name, indicator_name
      ORDER BY val ASC, yr ASC      
    ) AS rn
  FROM unpvt
)
SELECT
  country_name,
  indicator_name,
  yr  AS lowest_year,
  val AS lowest_value
FROM rnk
WHERE rn = 1
ORDER BY country_name, indicator_name;
