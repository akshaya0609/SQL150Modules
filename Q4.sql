SELECT customer_name, count(*) as total from orders
group by customer_name
-- having count(*) > (select avg(order_id) from orders where order_id=count(order_id) group by customer_name)
having count(*)> (select avg(ord) from (select count(*) as ord from orders group by customer_name) as avrg)
order by total desc;