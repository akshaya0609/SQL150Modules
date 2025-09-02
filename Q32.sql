DROP TABLE IF EXISTS phones;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_name      VARCHAR(10) PRIMARY KEY,
    monthly_salary INT NOT NULL,
    savings        INT NOT NULL
);
CREATE TABLE phones (
    phone_name VARCHAR(15) PRIMARY KEY,
    cost       INT NOT NULL
);
INSERT INTO users (user_name, monthly_salary, savings) VALUES
('Rahul', 40000, 15000),
('Vivek', 70000, 10000);
INSERT INTO phones (phone_name, cost) VALUES
('iphone-12', 60000),
('oneplus-12', 50000),
('iphone-14', 70000);

select user_name, group_concat(phone_name) from users u 
join phones p 
where u.savings >=0.2*p.cost and ((0.8*p.cost/6) <= (0.2*u.monthly_salary))
group by user_name;