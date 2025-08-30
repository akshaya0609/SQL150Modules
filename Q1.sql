-- CUSTOMER NAME, RETURN>50%
-- SELECT 100*COUNT(distinct r.order_id)/COUNT(o.order_id) from orders o left join returns r on o.order_id=r.order_id;

SELECT o.customer_name, ROUND(100*COUNT(distinct r.order_id)/COUNT(o.order_id),2) as perc from orders o
left join returns r on o.order_id=r.order_id
group by customer_name
having perc > 50;