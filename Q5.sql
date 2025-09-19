DROP TABLE IF EXISTS customer_transactions;
DROP TABLE IF EXISTS credit_card_bills;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS customers;
-- Customers
CREATE TABLE customers (
  customer_id  INT PRIMARY KEY,
  credit_limit INT
);
INSERT INTO customers (customer_id, credit_limit) VALUES
(101, 5000),
(102, 4000),
(103, 3000);
-- Loans
CREATE TABLE loans (
  loan_id       INT PRIMARY KEY,
  customer_id   INT,
  loan_due_date DATE
);
INSERT INTO loans (loan_id, customer_id, loan_due_date) VALUES
(1, 101, '2023-02-15'),
(2, 101, '2023-03-20'),
(3, 102, '2023-03-10'),
(4, 103, '2023-03-05');
-- Credit card bills
CREATE TABLE credit_card_bills (
  bill_id       INT PRIMARY KEY,
  customer_id   INT,
  bill_due_date DATE,
  bill_amount   INT
);
-- March 2023 bills drive utilization
INSERT INTO credit_card_bills (bill_id, customer_id, bill_due_date, bill_amount) VALUES
(10, 101, '2023-03-12', 1200),
(11, 101, '2023-03-28',  800),
(20, 102, '2023-03-05',  500),
(21, 102, '2023-03-25',  400),
(30, 103, '2023-03-18', 2000);
-- Transactions (on-time vs late payments)
-- transaction_type: 'loan' or 'bill'
CREATE TABLE customer_transactions (
  loan_bill_id     INT,
  transaction_date DATE,
  transaction_type VARCHAR(10)
);
INSERT INTO customer_transactions (loan_bill_id, transaction_date, transaction_type) VALUES
-- customer 101
(1 , '2023-02-10', 'loan'),  -- on-time (<= 2023-02-15)
(2 , '2023-03-25', 'loan'),  -- late     (>  2023-03-20)
(10, '2023-03-12', 'bill'),  -- on-time  (=  2023-03-12)
(11, '2023-04-01', 'bill'),  -- late     (>  2023-03-28)
-- customer 102
(3 , '2023-03-10', 'loan'),  -- on-time
(20, '2023-03-04', 'bill'),  -- on-time
(21, '2023-03-24', 'bill'),  -- on-time
-- customer 103
(4 , '2023-03-06', 'loan'),  -- late
(30, '2023-03-17', 'bill');  -- on-time

with all_bills as (
select customer_id,loan_id as bill_id,loan_due_date as due_date,0 as bill_amount
from loans
union all
select customer_id,bill_id,bill_due_date as due_date, bill_amount
from credit_card_bills
)
, on_time_calc as
(select b.customer_id,sum(b.bill_amount) as bill_amount
,count(*) as total_bills , sum(case when ct.transaction_date<=due_date then 1 else 0 end) as on_time_payments
from all_bills b
inner join customer_transactions ct on b.bill_id = ct.loan_bill_id
group by b.customer_id)
select c.customer_id , ROUND((ot.on_time_payments*1.0/ot.total_bills)*70 +
(case when ot.bill_amount*1.0/c.credit_limit < 0.3 then 1
when ot.bill_amount*1.0/c.credit_limit < 0.5 then 0.7
else 0.5 end) * 30 , 1 ) as cibil_score
from customers c
inner join on_time_calc ot on c.customer_id=ot.customer_id
ORDER BY c.customer_id ASC;		