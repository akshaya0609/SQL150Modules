DROP TABLE IF EXISTS creatrs;
DROP TABLE IF EXISTS youtube_videos;
CREATE TABLE creatrs (
    id INT,
    name VARCHAR(10),
    followers INT,
    platform VARCHAR(10)
);
CREATE TABLE youtube_videos (
    id INT,
    creator_id INT,
    publish_date DATE,
    views INT
);
-- creators table
INSERT INTO creatrs (id, name, platform, followers) VALUES
(100, 'Ankit', 'YouTube', 90000),
(100, 'Ankit', 'LinkedIn', 150000),
(101, 'Warikoo', 'YouTube', 500000),
(101, 'Warikoo', 'LinkedIn', 600000),
(101, 'Warikoo', 'Instagram', 800000),
(102, 'Dhruv', 'LinkedIn', 60000),
(102, 'Dhruv', 'YouTube', 900000),
(102, 'Dhruv', 'Instagram', 800000),
(103, 'Ravi', 'YouTube', 100000),
(103, 'Ravi', 'LinkedIn', 120000),
(103, 'Ravi', 'Instagram', 95000);
-- youtube_videos table
INSERT INTO youtube_videos (id, creator_id, publish_date, views) VALUES
(1, 100, '2024-01-01', 52000),
(2, 100, '2024-01-06', 62000),
(3, 101, '2024-01-05', 59000),
(4, 101, '2024-01-07', 22000),
(5, 102, '2024-01-05', 70000),
(6, 102, '2024-01-09', 90000),
(7, 103, '2024-01-11', 48000),
(8, 103, '2024-01-12', 53000),
(9, 104, '2024-01-15', 76000),
(10, 104, '2024-01-17', 81000),
(11, 105, '2024-01-20', 95000);

select y.creator_id, c.name from creatrs c 
join youtube_videos y on c.id=y.creator_id
where (case when (select count(distinct platform) from creatrs c2 
				 where c2.id=c.id and c2.followers>=100000 group by name)>=2 
then 1 else 0 end)=1 and  y.publish_date=(select max(y2.publish_date) from youtube_videos y2 
                                   where y2.creator_id=y.creator_id)
			 and y.views>50000
group by y.creator_id, c.name;

select c.id,c.name
from creatrs c
where c.id in (select id from creatrs where followers>=100000 group by id having count(distinct platform)>=2)
and c.id in (select y.creator_id from youtube_videos y 
			 where y.publish_date=(select max(y2.publish_date) from youtube_videos y2 
                                   where y2.creator_id=y.creator_id)
			 and y.views>50000)
group by c.id,c.name;