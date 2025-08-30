-- total consumption, total cost, avg(consumption) per household and per year, sort household/year 
SELECT household_id, SUM(consumption_kwh), sum(total_cost), avg(consumption_kwh), LEFT(billing_period,4)
from electricity_bill
where LEFT(billing_period,4) IN ('2023','2024')
group by household_id, billing_period
order by household_id, billing_period;