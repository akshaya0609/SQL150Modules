DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS listings;
-- 1) Listings
CREATE TABLE listings (
    listing_id     INT PRIMARY KEY,
    host_id        INT NOT NULL,
    minimum_nights INT,
    neighborhood   VARCHAR(20),
    price          DECIMAL(10,2),
    room_type      VARCHAR(20)
);

-- 2) Reviews
CREATE TABLE reviews (
    review_id   INT PRIMARY KEY,
    listing_id  INT NOT NULL,
    rating      INT,           -- assume 1..5
    review_date DATE,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id)
);
-- Hosts:
-- 1 -> 2 listings
-- 2 -> 3 listings
-- 3 -> 1 listing (should be excluded by the ≥2 listings rule)
-- 4 -> 2 listings (high ratings)

INSERT INTO listings (listing_id, host_id, minimum_nights, neighborhood, price, room_type) VALUES
(101, 1, 2, 'Downtown', 120.00, 'Entire home'),
(102, 1, 1, 'Downtown',  95.00, 'Private room'),
(201, 2, 3, 'Uptown',    80.00, 'Private room'),
(202, 2, 2, 'Uptown',   110.00, 'Entire home'),
(203, 2, 1, 'Midtown',   70.00, 'Shared room'),
(301, 3, 2, 'Beach',    150.00, 'Entire home'),
(401, 4, 2, 'Old Town', 130.00, 'Entire home'),
(402, 4, 1, 'Old Town',  85.00, 'Private room');
INSERT INTO reviews (review_id, listing_id, rating, review_date) VALUES
-- Host 1 (avg ≈ 4.60)
(1001, 101, 5, '2024-05-10'),
(1002, 101, 4, '2024-06-12'),
(1003, 101, 5, '2024-07-01'),
(1004, 102, 4, '2024-05-20'),
(1005, 102, 5, '2024-06-30'),
-- Host 2 (avg ≈ 3.20)
(2001, 201, 3, '2024-05-05'),
(2002, 201, 4, '2024-06-15'),
(2003, 202, 3, '2024-05-18'),
(2004, 202, 2, '2024-06-22'),
(2005, 203, 4, '2024-07-03'),
-- Host 3 (only 1 listing; will be excluded)
(3001, 301, 5, '2024-06-01'),
(3002, 301, 5, '2024-07-01'),
-- Host 4 (avg ≈ 4.80)
(4001, 401, 5, '2024-05-07'),
(4002, 401, 5, '2024-06-09'),
(4003, 401, 4, '2024-07-11'),
(4004, 402, 5, '2024-05-25'),
(4005, 402, 5, '2024-06-28');

SELECT host_id, round(avg(rating),2) as avrg from  listings l
join reviews r on l.listing_id=r.listing_id
group by host_id
having count(distinct l.listing_id)>=2
order by avrg desc
limit 2;
