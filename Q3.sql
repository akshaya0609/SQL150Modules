-- Creators table
DROP TABLE IF EXISTS creators;
CREATE TABLE creators (
    creator_id INT PRIMARY KEY,
    creator_name VARCHAR(20),
    followers INT
);
-- Posts table
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
    post_id VARCHAR(3) PRIMARY KEY,
    creator_id INT,
    publish_date DATE,
    impressions INT,
    FOREIGN KEY (creator_id) REFERENCES creators(creator_id)
);
-- Creators data
INSERT INTO creators (creator_id, creator_name, followers) VALUES
(1, 'Alice',60000),
(2, 'Bob',55000),
(3, 'Charlie', 70000),
(4, 'David',48000),
(5, 'Eva',80000);
-- Posts data
INSERT INTO posts (post_id, creator_id, publish_date, impressions) VALUES
('P01', 1, '2023-12-02', 40000),
('P02', 1, '2023-12-10', 35000),
('P03', 1, '2023-12-15', 35000), -- Alice total impressions in Dec = 110000 (3 posts)
('P04', 2, '2023-12-05', 50000),
('P05', 2, '2023-12-20', 60000), -- Bob total = 110000 but only 2 posts in Dec
('P06', 3, '2023-12-03', 30000),
('P07', 3, '2023-12-07', 40000),
('P08', 3, '2023-12-25', 35000),
('P09', 3, '2023-12-28', 15000), -- Charlie total = 120000 (4 posts)
('P10', 4, '2023-12-12', 70000),
('P11', 4, '2023-12-14', 35000), -- David followers < 50k
('P12', 5, '2023-11-29', 50000),
('P13', 5, '2023-12-05', 60000),
('P14', 5, '2023-12-18', 50000),
('P15', 5, '2023-12-30', 40000); -- Eva total = 150000 (3 posts in Dec)

-- creator_name, no.of posts in dec, no.of impressions in dec
/* 1- Creator should have more than 50k followers.
 2- Creator should have more than 100k impressions on the posts that they published in the month of Dec-2023.
 3- Creator should have published atleast 3 posts in Dec-2023.
 Write a SQL to get the list of top voice creators name along with no of posts and 
 by them in the month of Dec-2023. */

SELECT c.creator_name, count(*) as postno, sum(p.impressions) as impno
from creators c join posts p on c.creator_id=p.creator_id
where followers>50000 and year(publish_date)=2023 and month(publish_date)=12 
group by c.creator_name
having impno>100000 and postno>=3;
