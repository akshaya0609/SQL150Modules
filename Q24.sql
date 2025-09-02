DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS transactions;
CREATE TABLE users (
    user_id INT,
    username VARCHAR(10),
    opening_balance INT
);
CREATE TABLE transactions (
    id INT,
    from_userid INT,
    to_userid INT,
    amount INT
);
INSERT INTO users (user_id, username, opening_balance) VALUES
(100, 'Ankit', 1000),
(101, 'Rahul', 9000),
(102, 'Amit', 5000),
(103, 'Agam', 7500);
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES
(1, 100, 102, 500),
(2, 102, 101, 700),
(3, 101, 102, 600),
(4, 102, 100, 1500),
(5, 102, 101, 800),
(6, 102, 101, 300);

select u.user_id, u.username, u.opening_balance
-ifnull(sum(case when t.from_userid=u.user_id then t.amount end),0)
+ ifnull(sum(case when t.to_userid=u.user_id then t.amount end),0) as final_amount
from users u left join transactions t
on u.user_id=t.from_userid or u.user_id=t.to_userid
group by u.user_id, u.username, u.opening_balance
order by final_amount;							

