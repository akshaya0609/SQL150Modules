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