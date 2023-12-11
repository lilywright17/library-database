USE CFGLibrary;

-- Creating a stored procedure to update a loan to returned

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

-- Creating a stored function to find active members

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

-- Creating a stored procedure to find out which loans are overdue

DELIMITER // 
CREATE PROCEDURE overdueLoans()
BEGIN
	SELECT l.loanID, l.bookCopyID, m.firstName, m.lastName, m.email, l.endDate,
	DATEDIFF(CURDATE(), l.endDate) AS daysOverdue
	FROM loans l
		JOIN members m ON m.memberID = l.memberID
	WHERE (l.endDate < CURDATE())
	AND l.isReturned = FALSE
    ORDER BY daysOverdue DESC;
END //
DELIMITER ;

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

-- Creating a trigger to capitalise the first letter of the first name when inserting a row into members

CREATE TRIGGER capitaliseFirstName
BEFORE INSERT ON members
FOR EACH ROW
SET NEW.firstName = CONCAT(UPPER(SUBSTRING(NEW.firstName, 1, 1)), LOWER(SUBSTRING(NEW.firstName, 2)));

CREATE TRIGGER capitaliseLastName
BEFORE INSERT ON members
FOR EACH ROW
SET NEW.lastName = CONCAT(UPPER(SUBSTRING(NEW.lastName, 1, 1)), LOWER(SUBSTRING(NEW.lastName, 2)));

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
