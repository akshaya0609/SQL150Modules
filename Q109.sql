DROP TABLE IF EXISTS purchase;
CREATE TABLE purchase (
    customer_id   INT NOT NULL,
    purchase_date DATE NOT NULL,
    amount        INT NOT NULL
);

INSERT INTO purchase (customer_id, purchase_date, amount) VALUES
(101, '2024-02-01', 1200),
(101, '2024-03-15',  950),
(102, '2024-01-20', 3000),
(102, '2024-04-10', 1800),
(103, '2024-02-05', 4500),
(104, '2024-02-11',  700),
(104, '2024-03-21', 2500),
(105, '2024-01-09', 5200),
(106, '2024-02-14', 1500),
(106, '2024-02-28', 1600),
(107, '2024-03-02', 2300),
(108, '2024-03-18', 8000),
(109, '2024-04-01', 4100),
(110, '2024-01-31',  620),
(110, '2024-03-05', 2700),
(111, '2024-02-22', 2900),
(112, '2024-03-12', 10000),
(113, '2024-03-25', 3400);

select customer_id, max(amount) as single_purchase from purchase 
group by customer_id
order by single_purchase desc
limit 5;