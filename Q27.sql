DROP TABLE IF EXISTS income_tax_dates;
DROP TABLE IF EXISTS users;
-- Income Tax Dates table
CREATE TABLE income_tax_dates (
    financial_year VARCHAR(4),
    file_start_date DATE,
    file_due_date DATE
);
-- Users table
CREATE TABLE users (
    user_id INT,
    financial_year VARCHAR(4),
    return_file_date DATE
);
-- Income tax filing windows
INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES
('FY20', '2020-05-01', '2020-08-31'),
('FY21', '2021-06-01', '2021-09-30'),
('FY22', '2022-05-05', '2022-08-29'),
('FY23', '2023-05-05', '2023-08-31');
-- Users’ filing data
INSERT INTO users (user_id, financial_year, return_file_date) VALUES
(1, 'FY20', '2020-05-10'),
(1, 'FY21', '2021-10-10'),
(1, 'FY23', '2023-08-20'),
(2, 'FY20', '2020-05-15'),
(2, 'FY21', '2021-09-10'),
(2, 'FY22', '2022-08-20'),
(2, 'FY23', '2023-10-10');

select u.user_id, i.financial_year, (case when u.return_file_date > i.file_due_date then 'Late'
								    when u.return_file_date is null then 'Missed' end) as comments
from income_tax_dates i 
cross join (select distinct user_id from users) usr
left join users u on u.financial_year=i.financial_year and u.user_id=usr.user_id
where u.return_file_date > i.file_due_date or u.return_file_date is null
order by i.financial_year;

