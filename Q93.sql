CREATE TABLE ott_viewership (
  viewer_id    INT,
  show_id      INT,
  show_name    VARCHAR(20),
  genre        VARCHAR(10),
  country      VARCHAR(15),
  view_date    DATE,
  duration_min INT
);
INSERT INTO ott_viewership VALUES
(1, 101,'Stranger Things',       'Drama',   'United States','2023-05-01', 60),
(2, 102,'The Crown',             'Drama',   'United States','2023-05-01', 45),
(3, 103,'Breaking Bad',          'Drama',   'United States','2023-05-02', 55),
(4, 104,'Game of Thrones',       'Fantasy', 'United States','2023-05-01', 70),
(5, 105,'The Mandalorian',       'Sci-Fi',  'United States','2023-05-03', 50),
(6, 106,'The Witcher',           'Fantasy', 'United States','2023-05-03', 65),
(7, 107,'Friends',               'Comedy',  'United States','2023-05-01', 40),
(8, 108,'Brooklyn Nine-Nine',    'Comedy',  'Canada',       '2023-05-01', 30),
(9, 109,'The Office',            'Comedy',  'United States','2023-05-02', 35),
(10,110,'Parks and Recreation',  'Comedy',  'United States','2023-05-02', 25),
(11,111,'Stranger Things',       'Drama',   'United States','2023-05-03', 60);

WITH us_totals AS (
  SELECT
    show_id,
    show_name,
    genre,
    SUM(duration_min) AS total_duration
  FROM ott_viewership
  WHERE country = 'United States'
  GROUP BY show_id, show_name, genre
),
ranked AS (
  SELECT
    show_name,
    genre,
    total_duration,
    ROW_NUMBER() OVER (
      PARTITION BY genre
      ORDER BY total_duration DESC, show_name
    ) AS rn
  FROM us_totals
)
SELECT
  show_name,
  genre,
  total_duration
FROM ranked
WHERE rn <= 2
ORDER BY genre, total_duration DESC, show_name;
