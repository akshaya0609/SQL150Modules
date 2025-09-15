DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT,
    Email VARCHAR(25)
);
INSERT INTO Customers (CustomerID, Email) VALUES
(1, 'john@gmail.com'),
(2, 'jane.doe@yahoo.org'),
(3, 'alice.smith@amazon.net'),
(4, 'bob@gmail.com'),
(5, 'charlie@microsoft.com');

select substring_index(substring_index(email,'@', -1),'.',1) from Customers;

