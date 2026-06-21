-- Subquery Method
-- Display BranchName and EmployeeName where transactions occurred in the month of 'October' 
-- and the quantity purchased is greater than or equal to 5. Use EXISTS and JOIN

-- The main query gets BranchName and EmployeeName, where the subquery in WHERE Clause
-- checks whether that employee handles at least one transaction in October and a quantity over 5

SELECT 
    BranchName,
    EmployeeName

FROM MsEmployee AS e
JOIN MsBranch AS b
ON e.BranchID = b.BranchID

WHERE EXISTS (
    SELECT *
    FROM HeaderTransaction AS ht
    JOIN DetailTransaction AS dt
		ON ht.TransactionID = dt.TransactionID
    WHERE MONTHNAME(TransactionDate) = 'October'
    AND Quantity >= 5
);

-- Aggregation Method
-- Display the number of transaction count handled by each employee in descending
-- order, where ount of transactions, employeeID, employee name are included
SELECT 
    COUNT(TransactionID) AS 'Transaction Count',
    e.EmployeeID AS 'Employee ID',
    EmployeeName AS 'Employee Name'
FROM HeaderTransaction AS ht
JOIN MsEmployee AS e
    ON ht.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.employeeName
ORDER BY 'Transaction Count' DESC;

-- Creating A Procedure
-- Create a stored procedure named search that displays EmployeeName, Address, Phone, and Gender.
-- This procedure must search across all columns in the MsEmployee table based on user input of max 255 character
-- Use LIKE and % operator for substring searching that incorproates wildcard and not SUBSTRING() function 
-- because SUBSTRING() extracts text, while LIKE '%keyword%' is meant for searching substrings.

DELIMITER $$

CREATE PROCEDURE search(IN input VARCHAR(255)) -- Inside the () is the argument or parameter of the search procedure
BEGIN
    SELECT
        EmployeeName AS 'Employee Name',
        Address AS 'Employee Address',
        Phone AS 'Phone',
        Gender AS 'Gender'
    FROM MsEmployee
    WHERE EmployeeName LIKE CONCAT('%', input, '%')
        OR Address LIKE CONCAT('%', input, '%')
        OR Phone LIKE CONCAT('%', input, '%')
        OR Gender LIKE CONCAT('%', input, '%')
        OR DateOfBirth LIKE CONCAT('%', input, '%')
        OR Salary LIKE CONCAT('%', input, '%');
END$$

DELIMITER ;

CALL search('Ma');

-- Create a Stored Procedure named Check_Transaction that displays CustomerName, EmployeeName, 
-- BranchName, MusicInsName, and Price based on the inputted TransactionID. Use JOIN to combine 
-- 4 tables, which are HeaderTransaction, MsEmployee, MsBranch, and MsMusicIns

DROP PROCEDURE Check_Transaction;

DELIMITER $$

CREATE PROCEDURE Check_Transaction(IN input VARCHAR(255))
BEGIN

    SELECT
        CustomerName AS 'Customer Name',
        EmployeeName AS 'Employee Name',
        BranchName AS 'Branch Name',
        MusicIns AS 'Music Instrument',
        Price

    FROM HeaderTransaction AS ht

    JOIN MsEmployee AS e
        ON ht.EmployeeID = e.EmployeeID

    JOIN MsBranch AS b
        ON e.BranchID = b.BranchID

    JOIN DetailTransaction AS dt
        ON ht.TransactionID = dt.TransactionID

    JOIN MsMusicIns AS m
        ON dt.MusicInsID = m.MusicInsID

    WHERE ht.TransactionID = input;

END$$

DELIMITER ;

CALL Check_Transaction('TR001');

-- Create a storred procedure named Add_Stock_MusicIns to add stock to a music instrument based on the ID and stock quantity. 
-- If the inputted stock is less than or equal to 0, display the message "The inputted stock must be greater than 0"
-- If the Music Instrument ID is not found, display the message "Invalid code for music instrument" 

-- Use IF..THEN..ELSE logic designed to control logic in stored procedures, not CASE.. WHEN.. 
-- logic, which is used for returning values inside a query (normally in select)

DELIMITER $$

CREATE PROCEDURE Add_Stock_MusicIns (
    IN inputID VARCHAR(255),
    IN inputStock INT
)

BEGIN

    IF EXISTS (
        SELECT *
        FROM MsMusicIns
        WHERE MusicInsID = inputID
    ) THEN

        IF inputStock <= 0 THEN

            SELECT 'The inputted stock must be bigger than 0';

        ELSE

            UPDATE MsMusicIns
            SET Stock = Stock + inputStock
            WHERE MusicInsID = inputID;

            SELECT *
            FROM MsMusicIns
            WHERE MusicInsID = inputID;

        END IF;

    ELSE

        SELECT 'Invalid music instrument code';

    END IF;

END$$

DELIMITER ;

CALL Add_Stock_MusicIns('MI001', 2);

-- Create a Stored Procedure named Check_Sale to display the quantities for all Music Instrument Types
-- sold in a particular month along with the total quantity sold. Use JOIN and GROUP BY

DELIMITER $$
CREATE PROCEDURE Check_Sale(IN input VARCHAR(255)) 
BEGIN
	SELECT
		mt.MusicInsTypeName AS 'Music instrument Type',
        SUM(dt.Quantity) AS 'Qty Sold'
	FROM MsMusicInsType AS mt
    JOIN MsMusicIns AS mi
		ON mt.MusicInsTypeID = mi.MusicInsTypeID
	JOIN DetailTransaction AS dt
		ON mi.MusicInsID = dt.MusicInsID
	JOIN HeaderTransaction AS ht
		ON ht.TransactionID = dt.TransactionID
	 WHERE MONTHNAME(TransactionDate) = input
     GROUP BY mt.MusicInsTypeName;
END $$

DELIMITER ;

CALL Check_Sale('December');

DROP PROCEDURE Check_Sale;

-- Create a Stored Procedure named Check_Employee that displays EmployeeName, Address, Phone, DateOfBirth, and 
-- BranchName based on the inputted TransactionID. If the TransactionID is not provided, display all employee data.
        
DELIMITER $$
CREATE PROCEDURE Check_Employee (IN input VARCHAR(255))
BEGIN
	IF input != '' THEN
		SELECT
			e.EmployeeName AS 'Employee Name',
            e.Address AS 'Employee Address',
            e.Phone AS 'Phone Number',
            DATE_FORMAT(e.DateOfBirth, '%d %M %Y') AS 'Employee DOB',
            b.branchName AS 'Branch of Employment'
		FROM MsEmployee e
        JOIN MsBranch b
			ON e.BranchID = b.BranchID
		JOIN HeaderTransaction ht
			ON e.EmployeeID = ht.EmployeeID
		WHERE ht.TransactionID = input;
	ELSE 
		SELECT
			e.EmployeeName AS 'Employee Name',
            e.Address AS 'Employee Address',
            e.Phone AS 'Phone Number',
            DATE_FORMAT(e.DateOfBirth, '%d %M %Y') AS 'Employee DOB',
            b.branchName AS 'Branch of Employment'
		FROM MsEmployee e
        JOIN MsBranch b
			ON e.BranchID = b.BranchID;
	END IF;
END$$

DELIMITER ;
CALL Check_Employee('TR002');


