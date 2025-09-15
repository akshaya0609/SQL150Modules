DROP TABLE IF EXISTS product_ratings;
CREATE TABLE product_ratings (
  rating_id  INT PRIMARY KEY,
  product_id INT,
  user_id    INT,
  rating     DECIMAL(2,1)
);
INSERT INTO product_ratings VALUES
(1,101,1001,4.5),
(2,101,1002,4.8),
(3,101,1003,4.9),
(4,101,1004,5.0),
(5,101,1005,3.2),
(6,102,1006,4.7),
(7,102,1007,4.0);

select rating_id, product_id, user_id, rating from (
select pr.*, avg(pr.rating) over (partition by pr.product_id),
row_number() over (partition by pr.product_id
				order by abs(pr.rating - avg(pr.rating)) desc, pr.rating_id asc ) rn
from product_ratings pr) t
where rn=1
order by rating_id;