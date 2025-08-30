DROP TABLE IF EXISTS Borrowers;
DROP TABLE IF EXISTS Books;
-- 1) Books master
CREATE TABLE Books (
    BookID    INT PRIMARY KEY,
    BookName  VARCHAR(30) NOT NULL,
    Genre     VARCHAR(20)
);
-- 2) Borrowers (each row = one borrowed book by a borrower)
CREATE TABLE Borrowers (
    BorrowerID   INT PRIMARY KEY,
    BorrowerName VARCHAR(10) NOT NULL,
    BookID       INT NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
INSERT INTO Books (BookID, BookName, Genre) VALUES
(1,  'A Tale of Two Cities', 'Classic'),
(2,  'Brave New World','Dystopian'),
(3,  'Clean Code','Technology'),
(4,  'Data Science 101','Technology'),
(5,  'Ender''s Game','Sci-Fi'),
(6,  'Great Gatsby','Classic'),
(7,  'Harry Potter','Fantasy'),
(8,  'Invisible Man','Classic');
INSERT INTO Borrowers (BorrowerID, BorrowerName, BookID) VALUES
(1001, 'Alice',   3),  -- Clean Code
(1002, 'Alice',   6),  -- Great Gatsby
(1003, 'Alice',   2),  -- Brave New World
(1004, 'Bob',     1),  -- A Tale of Two Cities
(1005, 'Bob',     5),  -- Ender's Game
(1006, 'Charlie', 3),  -- Clean Code
(1007, 'Charlie', 4),  -- Data Science 101
(1008, 'Diana',   2),  -- Brave New World
(1009, 'Diana',   1),  -- A Tale of Two Cities
(1010, 'Eva',     4);  -- Data Science 101

SELECT BorrowerName,  group_concat(BookName)
-- group_concat( BookName order by BookName ASC SEPARATOR ',')
from Borrowers b join Books bk on b.BookID=bk.BookID
group by BorrowerName
Order by BorrowerName ASC;