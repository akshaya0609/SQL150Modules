DROP TABLE IF EXISTS credit_card;
CREATE TABLE credit_card(
    transaction_id INT,
    city VARCHAR(10),
    transaction_date DATE,
    card_type VARCHAR(10),
    gender VARCHAR(1),
    amount INT
);
INSERT INTO credit_card 
(transaction_id, city, transaction_date, card_type, gender, amount)VALUES
(1, 'Delhi',     '2024-01-13', 'Gold',     'F', 500),
(2, 'Bengaluru', '2024-01-13', 'Silver',   'M', 1000),
(3, 'Mumbai',    '2024-01-14', 'Silver',   'F', 1200),
(4, 'Bengaluru', '2024-01-14', 'Gold',     'F', 200),
(5, 'Bengaluru', '2024-01-14', 'Gold',     'F', 300),
(6, 'Delhi',     '2024-01-15', 'Silver',   'M', 700),
(7, 'Mumbai',    '2024-01-15', 'Gold',     'F', 900),
(8, 'Delhi',     '2024-01-15', 'Gold',     'F', 1000),
(9, 'Mumbai',    '2024-01-15', 'Silver',   'F', 850),
(10,'Mumbai',    '2024-01-16', 'Platinum', 'F', 1900),
(11,'Bengaluru', '2024-01-16', 'Platinum', 'M', 1250);

with cte as(
select city, sum(amount) as total,sum(case when gender='F' then amount else 0 end) as female_spend 
from credit_card group by city)
(select c.*, round((100*female_spend/total),2) as female_contribution
from cte c)
order by city;
