CREATE DATABASE CFGLibrary;

USE CFGLibrary;

-- Creating the tables

CREATE TABLE books (
	bookID INT PRIMARY KEY NOT NULL,
    bookTitle VARCHAR(255) NOT NULL
    );
    
CREATE TABLE authors (
	authorID INT PRIMARY KEY NOT NULL,
    firstName VARCHAR(255),
    lastName VARCHAR(255)
    );

CREATE TABLE publishers (
	publisherID INT PRIMARY KEY NOT NULL,
    publisherName VARCHAR(255)
    );
    
CREATE TABLE categories (
	categoryID INT PRIMARY KEY NOT NULL,
	categoryName VARCHAR(255)
	);

CREATE TABLE bookInformation (
	bookID INT,
    authorID INT,
    FOREIGN KEY (bookID) REFERENCES books(bookID),
    FOREIGN KEY (authorID) REFERENCES authors(authorID)
    );
    
CREATE TABLE bookCopies (
	bookCopyID INT PRIMARY KEY NOT NULL,
    yearPublished INT,
    bookID INT NOT NULL,
    publisherID INT,
    FOREIGN KEY (bookID) REFERENCES books(bookID),
    FOREIGN KEY (publisherID) REFERENCES publishers(publisherID)
	);
    
CREATE TABLE members (
	memberID INT PRIMARY KEY NOT NULL,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(30)
    );

CREATE TABLE loans (
	loanID INT PRIMARY KEY NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    bookCopyID INT NOT NULL,
    memberID INT,
    isReturned BOOLEAN,
    FOREIGN KEY (bookCopyID) REFERENCES bookCopies(bookCopyID),
    FOREIGN KEY (memberID) REFERENCES members(memberID)
    );

-- Adding data to the tables

INSERT INTO categories
	(categoryID, categoryName)
VALUES
	(1000, 'Romantic'),
    (2000, 'Self Help'),
    (3000, 'Historical Fiction'),
    (4000, 'Mystery'),
    (5000, 'Science Fiction'),
    (6000, 'Adventure'),
    (7000, 'Memoir'),
    (8000, 'Modern'),
    (9000, 'Classic')
    
INSERT INTO members
	(memberID, firstName, lastName, email)
VALUES 
	(19934, 'Lily', 'Wright', 'lily@wright.com'),
    (98477, 'Susan', 'Smith', 'su@gmail.com'),
    (98837, 'Teddy', 'Wright', 'teddythecat@hotmail.com'),
    (87766, 'Dotty', 'Wright', 'dottydots@outlook.com'),
    (96543, 'Layla', 'Humphreys', 'laylay@gmail.com'),
    (32321, 'Elaine', 'Humphreys', 'elaineh@hotmail.co.uk'),
    (54548, 'Lizzy', 'Wright', 'lizzy96@gmail.com'),
    (45567, 'Tom', 'Turner', 'tom45@ple.com')

INSERT INTO authors
	(authorID, firstName, lastName)
VALUES
	(123, 'Ryan', 'Holiday'),
    (432, 'David', 'Mitchell'),
    (856, 'Kazuo', 'Ishiguro'),
    (456, 'Milan', 'Kundera'),
    (876, 'Jonathan', 'Franzen'),
    (453, 'Ling', 'Ma'),
    (678, 'Jeanette', 'McCurdy'),
    (866, 'Franz', 'Kafka'),
    (674, 'Khaled', 'Hosseini'),
    (899, 'Madeleine', 'Thien'),
    (122, 'Elodie', 'Harper')
    
INSERT INTO books
	(bookID, bookTitle)
VALUES
	(1, 'The House with the Golden Door'),
    (2, 'The Temple of Fortuna'),
    (3, 'Do Not Say We Have Nothing'),
    (4, 'The Castle'),
    (5, 'Crossroads'),
    (6, 'Purity'),
    (7, 'I\'m Glad My Mom Died'),
    (8, 'And the Mountains Echoed'),
    (9, 'The Daily Stoic'),
    (10, 'Severance'),
    (11, 'Never Let Me Go'),
    (12, 'The Remains of the Day'),
    (13, 'The Unbearable Lightness of Being'),
    (14, 'Cloud Atlas'),
    (15, 'Black Swan Green'),
    (16, 'Immortality')

-- Adding categories to the bookInformation table

ALTER TABLE bookInformation
ADD COLUMN categoryID int AFTER authorID;

ALTER TABLE bookInformation ADD CONSTRAINT categoryID FOREIGN KEY (categoryID) REFERENCES categories (categoryID);

INSERT INTO bookInformation
	(bookID, authorID, categoryID)
VALUES
	(1, 122, 3000),
    (2, 122, 3000),
    (3, 899, 7000),
    (4, 866, 9000),
    (5, 876, 8000),
    (6, 876, 8000),
    (7, 678, 7000),
    (8, 674, 8000),
    (9, 123, 2000),
    (10, 453, 5000),
    (11, 856, 8000),
    (12, 856, 8000),
    (13, 456, 9000),
    (14, 432, 8000),
    (15, 432, 8000),
    (16, 456, 9000)
    
INSERT INTO publishers
	(publisherID, publisherName)
VALUES
	(10, 'Profile Books'),
    (20, 'Penguin'),
    (30, 'Harlequin'),
    (40, 'Titan'),
    (50, 'HarperCollins'),
    (60, 'Bloomsbury'),
    (70, 'Pegasus')
    
INSERT INTO bookCopies
	(bookCopyID, yearPublished, bookID, publisherID)
VALUES
	(001, 2022, 1, 50),
    (002, 2021, 1, 60),
    (003, 2023, 2, 60),
    (004, 2019, 3, 20),
    (005, 1998, 4, 50),
    (006, 2000, 4, 70),
    (007, 2015, 4, 70),
    (008, 2019, 4, 40),
    (009, 1985, 5, 40),
    (010, 2003, 5, 30),
    (011, 1990, 6, 30),
    (012, 2022, 7, 50),
    (013, 2023, 8, 20),
    (014, 2020, 9, 10),
    (015, 2010, 10, 30),
    (016, 2009, 11, 20),
    (017, 2023, 12, 30),
    (018, 2021, 12, 20),
    (019, 2009, 13, 70),
    (020, 2021, 14, 50),
    (021, 2003, 15, 50),
    (022, 2021, 16, 40)

INSERT INTO loans
	(loanID, bookCopyID, startDate, endDate, memberID, isReturned)
VALUES
	(00001, 005, '2023-09-12', '2023-10-12', 96543, FALSE),
    (00002, 004, '2023-09-13', '2023-11-13', 19934, FALSE),
    (00003, 007, '2023-09-13', '2023-10-13', 98477, TRUE),
    (00004, 007, '2023-09-15', '2023-10-15', 96543, FALSE),
    (00005, 009, '2023-09-17', '2023-10-17', 54548, TRUE),
    (00006, 022, '2023-09-20', '2023-10-20', 87766, FALSE),
    (00007, 020, '2023-09-25', '2023-11-25', 96543, TRUE),
    (00008, 001, '2023-09-28', '2023-11-28', 19934, TRUE),
    (00009, 002, '2023-10-01', '2023-11-01', 98477, TRUE),
    (00010, 008, '2023-10-02', '2023-11-02', 32321, FALSE),
    (00011, 018, '2023-10-05', '2023-11-05', 87766, TRUE),
    (00012, 017, '2023-10-06', '2023-11-06', 45567, FALSE),
    (00013, 013, '2023-10-12', '2024-01-12', 98477, TRUE),
    (00014, 011, '2023-10-14', '2023-11-14', 96543, TRUE),
    (00015, 010, '2023-10-15', '2023-11-15', 87766, TRUE),
    (00016, 006, '2023-10-16', '2023-11-16', 19934, FALSE)
    
-- View using 2 tables showing which members have taken out loans and how many

CREATE VIEW loansByMember
AS
SELECT CONCAT(m.firstName, ' ', m.lastName) AS memberName, m.memberID, COUNT(l.loanID) AS totalLoans
FROM members m
	JOIN loans l ON l.memberID = m.memberID
GROUP BY memberName;

SELECT * FROM loansByMember;

-- Query with a subquery using the loansByMember view to show which members haven't taken out loans

SELECT firstName, lastName FROM members
WHERE memberID NOT IN (SELECT memberID FROM loansByMember);


-- Stored function to find active members

DELIMITER //
CREATE FUNCTION activeMember(loans INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE activeMember VARCHAR(20);
	IF loans > 2 THEN
		SET activeMember = 'YES';
	ELSE SET activeMember = 'NO';
    END IF;
		RETURN (activeMember);
END //
DELIMITER ;

-- Using function to show which member IDs are active

SELECT m.memberID, activeMember(COUNT(l.loanID)) AS active
FROM loans l
	JOIN members m ON l.memberID = m.memberID
GROUP BY memberID;

FROM 
-- Stored procedure to find out which loans are overdue

DELIMITER // 
CREATE PROCEDURE overdueLoans()
BEGIN
	SELECT l.loanID, l.bookCopyID, m.firstName, m.lastName, m.email, l.endDate,
	DATEDIFF(CURDATE(), l.endDate) AS daysOverdue
	FROM loans l
		JOIN members m ON m.memberID = l.memberID
	WHERE (l.endDate < CURDATE())
	AND l.isReturned = FALSE;
END //
DELIMITER ;

-- Checking stored procedure works

CALL overdueLoans();

-- Creating a view by joining 2 tables to see how many book titles are in each category

CREATE VIEW titlesInEachCategory
AS
SELECT c.categoryName, COUNT(bi.bookID) as totalTitles
FROM categories c
	JOIN bookInformation bi ON c.categoryID = bi.categoryID
    JOIN books b ON b.bookID = bi.bookID
GROUP BY c.categoryName
ORDER BY totalTitles DESC;

SELECT * FROM titlesInEachCategory;

-- Creating a view from 3 tables showing book title, category name and author

CREATE VIEW titleAuthorCategory
AS
SELECT c.categoryName, b.bookTitle, a.firstName AS authorFirstName, a.lastName AS authorLastName
FROM categories c
	JOIN bookInformation bi ON c.categoryID = bi.categoryID
    JOIN books b ON b.bookID = bi.bookID
    JOIN authors a ON bi.authorID = a.authorID;

-- Checking the view

SELECT * from titleAuthorCategory;

-- Query to find which author's books have been borrowed the most

SELECT CONCAT(a.firstName, ' ', a.lastName) AS authorName,
	COUNT(l.loanID) as totalLoans
FROM authors a
	JOIN bookInformation bi ON a.authorID = bi.authorID
    JOIN bookCopies bc ON bc.bookID = bi.bookID
    JOIN loans l ON bc.bookCopyID = l.bookCopyID
GROUP BY authorName
ORDER BY totalLoans DESC;

-- Stored procedure for adding a new loan to the loans table

DELIMITER //
CREATE PROCEDURE AddLoan(
	IN StartDate DATE,
	IN EndDate DATE,
    IN BookCopyID INT,
    IN MemberID INT,
    IN IsReturned BOOLEAN)
BEGIN
    DECLARE newLoanID INT;
    
    SELECT IFNULL(MAX(loanID), 0) + 1 INTO newLoanID FROM loans;
    
    INSERT INTO loans (loanID, startDate, endDate, bookCopyID, memberID, isReturned)
    VALUES (newLoanID, StartDate, EndDate, BookCopyID, MemberID, IsReturned);
    
    SELECT newLoanID AS NewLoanNumber;
END //
DELIMITER ;

-- Checking the procedure by adding a loan then viewing the loans table

CALL AddLoan('2023-08-01', '2023-09-02', 003, 45567, FALSE);

SELECT * FROM loans;

-- Creating a trigger to capitalise the first letter of the first name when inserting a row into members

CREATE TRIGGER capitaliseFirstName
BEFORE INSERT ON members
FOR EACH ROW
SET NEW.firstName = CONCAT(UPPER(SUBSTRING(NEW.firstName, 1, 1)), LOWER(SUBSTRING(NEW.firstName, 2)));

CREATE TRIGGER capitaliseLastName
BEFORE INSERT ON members
FOR EACH ROW
SET NEW.lastName = CONCAT(UPPER(SUBSTRING(NEW.lastName, 1, 1)), LOWER(SUBSTRING(NEW.lastName, 2)));

-- Checking the triggers

INSERT INTO members
	(memberID, firstName, lastName, email)
VALUES 
	(19434, 'stacey', 'smith', 'staceyy@gmail.com');

SELECT * FROM members;

-- Creating an event that produces a daily report of current loans

DELIMITER //
CREATE EVENT dailyLoansReport
ON SCHEDULE EVERY 1 DAY
STARTS '2023-10-31 00:00:00'
DO
BEGIN
    SELECT loanID, bookCopyID, endDate
    FROM loans
    WHERE isReturned = FALSE;
END//

SHOW EVENTS; 

-- Creating a procedure to update a loan to returned

DELIMITER //
CREATE PROCEDURE returnLoan(
	IN Loan_ID INT
    )    
BEGIN
UPDATE loans 
SET isReturned = TRUE
WHERE loanID = Loan_ID;
END //
DELIMITER ;

-- Using returnLoan procedure to update loanID 00012 to returned

CALL returnLoan(00012);