DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
  amount INT,
  transaction_date DATE
);
INSERT INTO transactions (amount, transaction_date) VALUES
(-30,'2020-01-01'),
(-80,'2020-01-05'),
( 30,'2020-01-24'),
(-40,'2020-03-01'),
( 30,'2020-03-01'),
( 70,'2020-04-10'),
( 40,'2020-04-13'),
(-30,'2020-07-05'),
( 60,'2020-10-19'),
(-40,'2020-12-01'),
(-30,'2020-12-05');

with cte as (
select month(transaction_date) as tran_month, amount
from transactions)
,cte2 as(
select tran_month, sum(amount) as net_amount , sum(case when amount<0 then -1 * amount else 0
end) as credit_card_amount, sum(case when amount<0 then 1 else 0 end) as credit_card_transact_cnt
from cte
group by tran_month
)
select sum(net_amount) - sum(case when credit_card_amount >=100 and
credit_card_transact_cnt >=2 then 0 else 5 end)
- 5*(12-(select count(distinct tran_month) from cte)) as final_balance
from cte2;




