DROP TABLE IF EXISTS expenditures;
CREATE TABLE expenditures (
  user_name    VARCHAR(10),
  expenditure  INT,
  card_company VARCHAR(15)
);
INSERT INTO expenditures (user_name, card_company, expenditure) VALUES
('user1','Mastercard',1000),
('user1','Visa',500),
('user1','RuPay',2000),
('user2','Visa',2000),
('user3','Mastercard',5000),
('user3','Visa',2000),
('user3','Slice',500),
('user3','Amex',1000),
('user4','Mastercard',2000);

SELECT user_name,
SUM(CASE WHEN card_company='Mastercard' THEN expenditure ELSE 0 END) as mc_expenditure,
SUM(CASE WHEN card_company<>'Mastercard' THEN expenditure ELSE 0 END) as other_expense
FROM expenditures
GROUP BY user_name
HAVING other_expense>mc_expenditure and mc_expenditure>0;
