CREATE TABLE sales_amount(
  sale_date      DATE,
  sales_amount   INT,
  currency       VARCHAR(20)
);
INSERT INTO sales_amount VALUES
('2020-01-01', 500, 'INR'),
('2020-01-01', 100, 'GBP'),
('2020-01-02',1000, 'INR'),
('2020-01-02', 500, 'GBP'),
('2020-01-03', 500, 'INR'),
('2020-01-17', 200, 'GBP'),
('2020-01-18', 200, 'Ringgit'),
('2020-01-05', 800, 'INR'),
('2020-01-06', 150, 'GBP'),
('2020-01-10', 300, 'INR'),
('2020-01-15', 100, 'INR');

CREATE TABLE exchange_rate(
  from_currency  VARCHAR(20),
  to_currency    VARCHAR(20),
  exchange_rate  DECIMAL(6,2),
  effective_date DATE
);
INSERT INTO exchange_rate VALUES
('INR','USD',0.14,'2019-12-31'),
('INR','USD',0.15,'2020-01-02'),
('GBP','USD',1.32,'2019-12-20'),
('GBP','USD',1.30,'2020-01-01'),
('GBP','USD',1.35,'2020-01-16'),
('GBP','USD',1.35,'2020-01-25'),
('Ringgit','USD',0.30,'2020-01-10'),
('INR','USD',0.16,'2020-01-10'),
('GBP','USD',1.33,'2020-01-05');

SELECT  s.sale_date,
        SUM(
            s.sales_amount *
            ( SELECT e.exchange_rate
              FROM exchange_rate e
              WHERE e.from_currency = s.currency
                AND e.to_currency   = 'USD'
                AND e.effective_date <= s.sale_date
              ORDER BY e.effective_date DESC
              LIMIT 1               -- latest applicable rate
            )
        ) AS total_usd
FROM sales_amount s
GROUP BY s.sale_date
ORDER BY s.sale_date;