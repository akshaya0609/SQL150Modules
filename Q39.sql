DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS stores;
-- Stores
CREATE TABLE stores (
  store_id   INT PRIMARY KEY,
  store_name VARCHAR(20),
  location   VARCHAR(20)
);

INSERT INTO stores (store_id, store_name, location) VALUES
(1, 'Store A', 'New York'),
(2, 'Store B', 'New York'),
(3, 'Store C', 'Los Angeles'),
(4, 'Store D', 'Los Angeles'),
(5, 'Store E', 'Chicago'),
(6, 'Store F', 'Chicago');

-- Transactions
CREATE TABLE transactions (
  transaction_id   INT PRIMARY KEY,
  customer_id      INT,
  store_id         INT,
  transaction_date DATE,
  amount           INT
);

INSERT INTO transactions(transaction_id, customer_id, store_id, transaction_date, amount)VALUES
(1, 101, 1, '2023-01-05', 100),
(2, 102, 1, '2023-01-10', 150),
(3, 103, 3, '2023-01-15', 200),
(4, 104, 3, '2023-01-20', 250),
(5, 105, 5, '2023-01-25', 800),
(6, 101, 2, '2023-02-05', 120),
(7, 102, 2, '2023-02-10', 130),
(8, 103, 4, '2023-02-15', 180),
(9, 104, 4, '2023-02-20', 230);

select location,
max(case when high=1 then dt end) as highest_month,
max(case when high=1 then sales end) as highest_sales,
max(case when low=1 then dt end) as lowest_month,
max(case when low=1 then sales end) as lowest_sales
from
(select location, dt, sales,
row_number() over (partition by location order by sales desc, dt desc) as high,
row_number() over (partition by location order by sales asc, dt asc) as low
from
(select location, date_format(transaction_date,'%y-%m') as dt, sum(amount) as sales
from stores s join transactions t using (store_id)
where year(transaction_date)='2023'
group by location, dt) m ) rn
group by location
order by location;

/*we use MAX() simply as a convenient aggregate that ignores NULLs and
returns the single selected value; MIN() would be equivalent here because
ROW_NUMBER() ensures uniqueness.*/

select location,
min(case when high=1 then dt end) as highest_month,
min(case when high=1 then sales end) as highest_sales,
min(case when low=1 then dt end) as lowest_month,
min(case when low=1 then sales end) as lowest_sales
from
(select location, dt, sales,
row_number() over (partition by location order by sales desc, dt desc) as high,
row_number() over (partition by location order by sales asc, dt asc) as low
from
(select location, date_format(transaction_date,'%y-%m') as dt, sum(amount) as sales
from stores s join transactions t using (store_id)
where year(transaction_date)='2023'
group by location, dt) m ) rn
group by location
order by location;
