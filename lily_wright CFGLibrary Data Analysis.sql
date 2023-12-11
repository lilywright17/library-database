USE CFGLibrary;

-- Creating a view using 2 tables showing which members have taken out loans and how many

CREATE VIEW loansByMember
AS
SELECT CONCAT(m.firstName, ' ', m.lastName) AS memberName, m.memberID, COUNT(l.loanID) AS totalLoans
FROM members m
	JOIN loans l ON l.memberID = m.memberID
GROUP BY memberName
ORDER BY totalLoans DESC;

SELECT * FROM loansByMember;

-- Query with a subquery using the loansByMember view to show which members haven't taken out loans

SELECT firstName, lastName, memberID FROM members
WHERE memberID NOT IN (SELECT memberID FROM loansByMember);

-- Using stored function activeMember to show which member IDs are active

SELECT m.memberID, activeMember(COUNT(l.loanID)) AS active
FROM loans l
	JOIN members m ON l.memberID = m.memberID
GROUP BY memberID;

-- Using stored procedure overdueLoans to view loans that are currently overdue

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

-- Using the AddLoan stored procedure then viewing the loans table to check

CALL AddLoan('2023-08-01', '2023-09-02', 003, 45567, FALSE);

SELECT * FROM loans;

-- Adding a new member into the members table, checking the stored triggers to capitalise the first and last name

INSERT INTO members
	(memberID, firstName, lastName, email)
VALUES 
	(19434, 'stacey', 'smith', 'staceyy@gmail.com');

SELECT * FROM members;

-- Using returnLoan procedure to update loanID 00012 to returned

CALL returnLoan(00012);