DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS sales;
CREATE TABLE categories (
  category_id   INT PRIMARY KEY,
  category_name VARCHAR(12)
);

CREATE TABLE sales (
  sale_id     INT PRIMARY KEY,
  category_id INT,
  amount      INT,
  sale_date   DATE
);
INSERT INTO categories VALUES
(1,'Electronics'),
(2,'Clothing'),
(3,'Books'),
(4,'Home Decor');
INSERT INTO sales VALUES
(1,1,500,'2022-01-05'),
(2,1,800,'2022-02-10'),
(4,3,200,'2022-02-20'),
(5,3,150,'2022-03-01'),
(6,4,400,'2022-02-25'),
(7,4,600,'2022-03-05');

select c.category_name, coalesce(sum(s.amount),0) as total
from categories c left join sales s using (category_id)
group by c.category_name
order by total asc;
