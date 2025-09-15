DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS calendar_dim;
CREATE TABLE bookings (
    room_id INT,
    customer_id INT,
    check_in_date DATE,
    check_out_date DATE
);
CREATE TABLE calendar_dim (
    cal_date DATE
);
INSERT INTO bookings (room_id, customer_id, check_in_date, check_out_date) VALUES
(1, 101, '2024-04-01', '2024-04-04'),
(2, 102, '2024-04-02', '2024-04-05'),
(1, 103, '2024-04-02', '2024-04-06'),
(3, 104, '2024-04-03', '2024-04-05'),
(2, 105, '2024-04-04', '2024-04-07'),
(1, 106, '2024-04-05', '2024-04-08'),
(3, 107, '2024-04-05', '2024-04-09');
INSERT INTO calendar_dim (cal_date) VALUES
('2024-04-01'),
('2024-04-02'),
('2024-04-03'),
('2024-04-04'),
('2024-04-05'),
('2024-04-06'),
('2024-04-07'),
('2024-04-08'),
('2024-04-09'),
('2024-04-10');


-- OR
with cte as (
select room_id,customer_id,c.cal_date as book_date
from bookings b
inner join calendar_dim c on c.cal_date >= b.check_in_date and c.cal_date < b.check_out_date
)
select room_id,book_date , group_concat(customer_id ORDER BY customer_id) as customers
from cte
group by room_id,book_date
having count(*)>1
order by room_id,book_date ;

select b.room_id, group_concat(distinct b.customer_id)
from bookings b join bookings c
on b.check_out_date>=c.check_in_date
group by room_id
having count(distinct b.customer_id)>1
order by room_id;




SELECT 
    c.cal_date,
    b.room_id,
    GROUP_CONCAT(b.customer_id ORDER BY b.customer_id) AS customers
FROM calendar_dim c
JOIN bookings b
    ON c.cal_date >= b.check_in_date
   AND c.cal_date < b.check_out_date   -- check-out date not inclusive
GROUP BY c.cal_date, b.room_id
HAVING COUNT(DISTINCT b.customer_id) > 1
ORDER BY b.room_id, c.cal_date;
