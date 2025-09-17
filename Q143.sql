CREATE TABLE airbnb_listings (
    property_id INT,
    neighborhood VARCHAR(50),
    cost_per_night INT,
    room_type VARCHAR(50),
    amenities TEXT
);
INSERT INTO airbnb_listings VALUES
(101, 'Manhattan', 80,  'Entire home', 'tv; INTERNET; Kitchen'),
(102, 'Manhattan', 90,  'Entire home', 'TV; internet; Kitchen'),
(103, 'Brooklyn', 65,  'Apartment',   'TV; Internet; Air Condi'),
(104, 'Queens',   50,  'Entire home', 'TV; Internet; WiFi; Balcony'),
(105, 'Bronx',    70,  'Apartment',   'TV; Internet; Parking'),
(106, 'Bronx',    80,  'Entire home', 'TV; Internet'),
(107, 'Bronx',    85,  'Entire home', 'TV; Internet; Pool'),
(108, 'Manhattan',75,  'Private room','TV; Internet; Heating'),
(109, 'Manhattan',70,  'Shared room', 'TV; Internet'),
(203, 'Brooklyn', 60,  'Entire home', 'TV; Internet; Heating'),
(204, 'Brooklyn', 55,  'Apartment',   'TV; Kitchen'),
(205, 'Queens',   45,  'Entire home', 'WiFi; Balcony; Garden');

SELECT neighborhood, property_id, cost_per_night FROM (
SELECT property_id, neighborhood, cost_per_night,
ROW_NUMBER() OVER (PARTITION BY neighborhood ORDER BY cost_per_night ASC,LENGTH(amenities) DESC) AS rn
FROM airbnb_listings
WHERE room_type IN ('Entire home','Apartment')
AND LOWER(amenities) LIKE '%tv%'
AND LOWER(amenities) LIKE '%internet%'
) t
WHERE rn = 1
ORDER BY neighborhood;
