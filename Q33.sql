DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
  order_id           INT PRIMARY KEY,
  user_id            INT,
  transaction_amount DECIMAL(5,2),
  transaction_date   DATE
);
INSERT INTO transactions (order_id, user_id, transaction_amount, transaction_date) VALUES
(1, 101,  50.00, '2024-02-24'),
(2, 102,  75.00, '2024-02-24'),
(3, 103, 100.00, '2024-02-25'),
(4, 104,  30.00, '2024-02-26'),
(5, 105, 200.00, '2024-02-27'),
(6, 106,  50.00, '2024-02-27'),
(7, 107, 150.00, '2024-02-27'),
(8, 108,  80.00, '2024-02-29');

with cte as(
select round(avg(transaction_amount),2) as AOV, transaction_date
from transactions group by transaction_date
)
select transaction_date, AOV,
max(AOV) over()-AOV as difference
from cte
order by AOV
limit 1;

/*select transaction_date, round(avg(transaction_amount),2) as aov, max(a)-min(a) as difference
from (select transaction_date, min(a), max(a) 
      from (select transaction_date, round(avg(transaction_amount),2) as a from transactions
            group by transaction_date) d
	  group by transaction_date) c
order by aov;*/

select transaction_date, aov, 
(select max(aov) from (select round(avg(transaction_amount),2) as aov from transactions
                       group by transaction_date) mx)-aov as difference
from (select transaction_date, round(avg(transaction_amount),2) as aov from transactions
            group by transaction_date) s
where aov= (select min(aov) from (select round(avg(transaction_amount),2) as aov from transactions
                                  group by transaction_date) mn)
order by transaction_date;