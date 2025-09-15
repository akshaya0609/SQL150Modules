DROP TABLE IF EXISTS loans;
CREATE TABLE loans (
  loan_id      INT,
  customer_id  INT,
  loan_amount  INT,
  due_date     DATE
);
INSERT INTO loans (loan_id, customer_id, loan_amount, due_date) VALUES
(1, 1,  5000, '2023-01-15'),
(2, 2,  8000, '2023-02-20'),
(3, 3, 10000, '2023-03-10'),
(4, 4,  6000, '2023-04-05'),
(5, 5,  7000, '2023-05-01');
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
  payment_id    INT,
  loan_id       INT,
  payment_date  DATE,
  amount_paid   INT
);
INSERT INTO payments (payment_id, loan_id, payment_date, amount_paid) VALUES
(1, 1, '2023-01-10', 2000),
(2, 1, '2023-02-10', 1500),
(3, 2, '2023-02-20', 8000);

select l.loan_id, l.loan_amount, l.due_date, 
case when coalesce(sum(p.amount_paid),0)>=l.loan_amount then 1 else 0 end as flag_1,
case when coalesce(sum(case when p.payment_date>=l.due_date then 1 else 0 end)>=l.loan_amount) then p.amount_paid
else 0 end
as flag_2
from loans l join payments p using (loan_id)
group by l.loan_id,l.loan_amount,l.due_date
order by l.loan_id;