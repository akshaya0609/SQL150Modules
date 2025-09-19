DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS listng;
CREATE TABLE listng (
  listing_id     INT PRIMARY KEY,
  host_id        INT,
  location       VARCHAR(20),
  room_type      VARCHAR(20),
  price          DECIMAL(10,2),
  minimum_nights INT
);
INSERT INTO listng (listing_id, host_id, location, room_type, price, minimum_nights) VALUES
(1, 101, 'Downtown', 'Entire home/apt', 150.00, 2),
(2, 101, 'Downtown', 'Private room',     80.00, 1),
(3, 101, 'Downtown', 'Entire home/apt', 200.00, 3),
(4, 102, 'Downtown', 'Entire home/apt', 120.00, 2),
(5, 102, 'Downtown', 'Private room',    100.00, 1),
(6, 102, 'Midtown',  'Entire home/apt', 250.00, 2),
(7, 103, 'Midtown',  'Entire home/apt',  70.00, 1),
(8, 103, 'Midtown',  'Private room',     90.00, 1),
(9, 104, 'Midtown',  'Private room',    170.00, 1);
CREATE TABLE bookings (
  booking_id    INT PRIMARY KEY,
  listing_id    INT,
  checkin_date  DATE,
  checkout_date DATE
);
INSERT INTO bookings (booking_id, listing_id, checkin_date, checkout_date) VALUES
(1, 1, '2023-01-05', '2023-01-10'),
(2, 1, '2023-01-11', '2023-01-13'),
(3, 2, '2023-01-15', '2023-01-25'),
(4, 3, '2023-01-10', '2023-01-17'),
(5, 3, '2023-01-19', '2023-01-21'),
(6, 3, '2023-01-22', '2023-01-23'),
(7, 4, '2023-01-03', '2023-01-05'),
(8, 5, '2023-01-05', '2023-01-12'),
(9, 6, '2023-01-15', '2023-01-19'),
(10, 6, '2023-01-20', '2023-01-22'),
(11, 7, '2023-01-25', '2023-01-29');

WITH occupancy AS (
    SELECT 
        l.location,
        l.room_type,
        AVG(DATEDIFF(b.checkout_date, b.checkin_date)) AS avg_occupancy
    FROM listng l
    JOIN bookings b 
        ON l.listing_id = b.listing_id
    WHERE b.checkin_date >= '2023-01-01' 
      AND b.checkout_date <= '2023-01-31'
    GROUP BY l.location, l.room_type
),
ranked AS (
    SELECT 
        location,
        room_type,
        ROUND(avg_occupancy, 2) AS avg_occupancy,
        RANK() OVER (PARTITION BY location ORDER BY avg_occupancy DESC) AS rnk
    FROM occupancy
)
SELECT 
    location,
    room_type,
    avg_occupancy
FROM ranked
WHERE rnk = 1
ORDER BY avg_occupancy DESC;