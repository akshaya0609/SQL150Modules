CREATE TABLE tickets (
    airline_number VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round CHAR(1),
    ticket_count INT
);
INSERT INTO tickets (airline_number, origin, destination, oneway_round, ticket_count) VALUES
('DEF456', 'BOM', 'DEL', 'O', 150),
('GHI789', 'DEL', 'BOM', 'R',  50),
('JKL012', 'BOM', 'DEL', 'R',  75),
('MNO345', 'DEL', 'NYC', 'O', 200),
('PQR678', 'NYC', 'DEL', 'O', 180),
('STU901', 'NYC', 'DEL', 'R',  60),
('ABC123', 'DEL', 'BOM', 'O', 100),
('VWX234', 'DEL', 'NYC', 'R',  90);

select origin, destination, sum(ticket_count) as total 
from tickets
group by origin, destination
having sum(ticket_count) = (select max(t.t_count) from 
(select sum(ticket_count) as t_count from tickets group by origin,destination) as t);
-- OR
select origin, destination, sum(ticket_count) as total 
from tickets
group by origin, destination
order by total desc limit 1;
