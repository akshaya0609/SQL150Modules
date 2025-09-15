DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
  company_id   INT PRIMARY KEY,
  company_name VARCHAR(30)
);
INSERT INTO companies VALUES
(1,'Alpha Corp'),
(2,'Beta Ltd');
DROP TABLE IF EXISTS revenue;
CREATE TABLE revenue (
  company_id INT,
  year       INT,
  revenue    DECIMAL(10,2)
);
INSERT INTO revenue VALUES
(1,2018,100000.00),
(1,2019,125000.00),
(1,2020,156250.00),
(1,2021,200000.00),
(1,2022,260000.00),
(2,2018, 80000.00),
(2,2019,100000.00),
(2,2020,130000.00),
(2,2021,156000.00);

WITH cte1 AS (
  SELECT r.*, LAG(revenue) OVER (PARTITION BY company_id ORDER BY year) AS prev_rev
  -- ,lag(year) over (partition by company_id) as prev_year
  FROM revenue r
),
cte2 AS (        -- count transitions that violate the 25% rule
  SELECT
    company_id,
    SUM(revenue) AS total_lifetime_revenue,
    SUM(CASE WHEN prev_rev IS NOT NULL -- and year=prev_year+1
              AND revenue < 1.25 * prev_rev
             THEN 1 ELSE 0 END) AS bad_transitions,
    SUM(CASE WHEN prev_rev IS NOT NULL THEN 1 ELSE 0 END) AS transitions
  FROM cte1
  GROUP BY company_id
)
SELECT
  c.company_id,
  c.company_name,
  total_lifetime_revenue
FROM cte2 a
JOIN companies c ON c.company_id = a.company_id
WHERE a.transitions > 0          -- at least one year-to-year step
  AND a.bad_transitions = 0      -- every step is >= 25%
ORDER BY c.company_id;

-- OR 
WITH revenue_growth AS (
SELECT
company_id,
year,
revenue,
CASE WHEN revenue >= 1.25 * LAG(revenue,1,0) OVER (PARTITION BY company_id ORDER BY year) THEN 1 ELSE 0
END AS revenue_growth_flag
FROM revenue
)
SELECT
company_id,
sum(revenue) as total_revenue
FROM revenue_growth
where company_id not in
(select company_id from revenue_growth where revenue_growth_flag=0)
group by company_id
ORDER BY company_id;
