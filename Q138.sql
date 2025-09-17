DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id   INT PRIMARY KEY,
  customer_name VARCHAR(50),
  email         VARCHAR(100),
  phone         VARCHAR(40),
  address       VARCHAR(100)
);
INSERT INTO customers (customer_id, customer_name, email, phone, address) VALUES
(1 , ' John Doe ','JOHN.DOE@GMAIL.COM','(123)-456-7890','123 Main St'),
(2 , '  Jane Smith','Jane.Smith@Yahoo.com ','987 654 3210',' 456 Oak Ave '),
(3 , 'JOHN DOE','JOHN.DOE@GMAIL.COM','123-456-7890',NULL),          -- dup email of id=1
(4 , 'Alex White','Alex.White@Outlook.com','111-222-3333','  '),          -- blank address
(5 , 'Bob Brown ',' Bob.Brown@Gmail.com','+1 (555) 888-9999',  '789 Pine Rd'),
(6 , 'Emily  Davis','EMILY.DAVIS@GMAIL.COM','555 666 7777',NULL),
(7 , ' Michael Johnson','Michael.Johnson@Hotmail.com',  '444-555-6666','12 River St'),
(8 , 'David Miller','DAVID.MILLER@YAHOO.COM','(777) 888-9999','9 Elm St'),
(9 , 'David M ','david.miller@yahoo.com','999.888.7777',NULL),
(10, 'WILLIAM TAYLOR','WILLIAM.TAYLOR@OUTLOOK.COM',   '+1 123-456-7890','1 Market Pl'),
(11, 'Michael Johnson','Michael.Johnson@Hotmail.com',  '444-555-6666','Apt 2B'),      -- dup email of id=7
(12, 'Olivia Brown','Olivia.Brown@Yahoo.com','333 222 1111',NULL);

SELECT MIN(customer_id) AS customer_id,
MIN(TRIM(customer_name)) AS customer_name,
LOWER(TRIM(email)) AS email,
MIN(REPLACE(REPLACE(REPLACE(REPLACE(phone, '-', ''), ' ', ''), '(', ''), ')', '')) AS phone,
MIN(COALESCE(NULLIF(TRIM(address), ''), 'Unknown')) AS address
FROM customers
GROUP BY LOWER(TRIM(email))
ORDER BY customer_id;


SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

