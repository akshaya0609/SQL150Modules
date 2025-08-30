DROP TABLE IF EXISTS electricity_bill;
CREATE TABLE electricity_bill (
    bill_id INT PRIMARY KEY,
    household_id INT,
    billing_period VARCHAR(7),       -- format 'YYYY-MM'
    consumption_kwh DECIMAL(10,2),
    total_cost DECIMAL(10,2)
);
INSERT INTO electricity_bill (bill_id, household_id, billing_period, consumption_kwh, total_cost) VALUES
-- Household 1 - 2023
(1, 1, '2023-01', 250.50,  30.00),
(2, 1, '2023-02', 220.75,  28.00),
(3, 1, '2023-03', 270.00,  32.50),
-- Household 1 - 2024
(4, 1, '2024-01', 300.00,  36.00),
(5, 1, '2024-02', 280.50,  34.00),
-- Household 2 - 2023
(6, 2, '2023-01', 150.00,  20.00),
(7, 2, '2023-02', 180.00,  22.50),
(8, 2, '2023-03', 175.50,  21.50),
-- Household 2 - 2024
(9, 2, '2024-01', 200.00,  25.00),
(10, 2, '2024-02', 210.75, 26.00),
(11, 2, '2024-03', 195.25, 24.50),
-- Household 3 - 2023
(12, 3, '2023-11', 320.00,  40.00),
(13, 3, '2023-12', 310.50,  38.00);

-- total consumption, total cost, avg(consumption) per household and per year, sort household/year 
SELECT household_id, SUM(consumption_kwh), sum(total_cost), avg(consumption_kwh), LEFT(billing_period,4)
from electricity_bill
where LEFT(billing_period,4) IN ('2023','2024')
group by household_id, billing_period
order by household_id, billing_period;