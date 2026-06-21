-- Selection
-- Filter records of MsEMployee where salary is bigger than 4 Mio and 
-- the last 2 digits of the employee's phone number are divisible by 5
SELECT *
FROM MsEmployee
WHERE Salary > 4000000 AND RIGHT(Phone,2) % 5;
-- Projection
-- Combining Selection x Projection

-- Display the EmployeeID, EmployeeName, and Gender columns of the 
-- MsEmployee table where gender is female, but only up to first 3 records
SELECT EmployeeID, EmployeeName, Gender
FROM MsEmployee
WHERE Gender = 'F'
LIMIT 3;

-- Creating View (View, Between, Like)
-- Create a view named view_1 and display data from the MsMusicIns table where 
-- the price is between 5000000 and 10000000, and the music instrument name starts with "Yamaha".
-- Then display the view and create the syntax to delete the view.
CREATE VIEW view_1 AS
SELECT *
FROM MsMusicIns
WHERE Price > 6000000
AND Price <= 10000000;
-- of use condition BETWEEN 5000000 AND 10000000, then it includes both 5000000 and 10000000

SELECT * FROM view_1;

CREATE VIEW view_2 AS
SELECT * 
FROM MsMusicIns
WHERE MUsicIns LIKE 'Yamaha%';
-- % = wildcard operator so can detect minor misspelling like 'Yamah' equal to 'Yamaha'

SELECT * FROM view_2;

-- Display BranchEmployee (obtained from EmployeeName where the first name is replaced with BranchID) for employees whose names consist of at least 3 words.
-- Use CONCAT and SUBSTRING AS in the query so that BranchEmployee records can be obtained
-- For example, 'William Wijaya' --> BR003 Wijaya, 
SELECT CONCAT(BranchID, ' ', 
		SUBSTRING(EmployeeName, LOCATE(' ', EmployeeName)+1)) 
	   AS BranchEmployee
FROM MsEmployee;

-- For the BranchEmployee records, only display those with more than 2 words for the name (i.e. has a middle name)
-- Use REPLACE and LIKE for the condiiton to obtain only those with 3 or more words for the name
SELECT CONCAT(
        BranchID, ' ',
        SUBSTRING(EmployeeName, LOCATE(' ', EmployeeName) + 1)
       ) AS BranchEmployee
FROM MsEmployee
WHERE CHAR_LENGTH(EmployeeName)
      - CHAR_LENGTH(REPLACE(EmployeeName, ' ', '')) >= 2; -- Only names with 2 spaces or more (i.e. 3 words or more)

SELECT CONCAT(BranchID, ' ', 
		SUBSTRING(EmployeeName, LOCATE(' ', EmployeeName)+1)) 
	   AS BranchEmployee
FROM MsEmployee
WHERE EmployeeName LIKE '% % %';

-- Display the Brand (obtained from the first word of MusicInsName), Price (obtained from Price with 'Rp. ' added in front of it),
-- Stock, and Instrument Type (obtained from MusicTypeName). Use SUBSTRING_INDEX, CONCAT, and JOIN in the query
SELECT 
	SUBSTRING_INDEX(MusicIns, ' ', 1) AS BRAND, 
    -- takes the first word from the instrument name as the brand, since it's a positive index before space
    CONCAT ('Rp. ', PRICE) AS PRICE, -- adds the Rp. before the price 
    Stock, 
    MusicInsTypeName AS 'Instrument Type' -- we don't really use CAST in MySQL
FROM MsMusicIns 
JOIN MsMusicInsType -- since the music ins type originate from this table, the default is inner join
	ON MsMusicIns.MusicInsTypeID = MsmusicInsType.MusicInsTypeID;
    
-- Display transaction records ordered by the most recent transaction date.
-- The displayed data must consist of Employee Name, Employee Gender (either Male or Female,
-- Transaction Date in dd Month yyyy format, and Customer Name, 
-- for transactions whwre employee gender is 'Male' and the employee name contains 2 words or more.
-- Use CASE WHEN, DATE_FORMAT, JOIN, LIKE, and ORDER BY.

SELECT e.EmployeeName AS 'Employee Name', 
	CASE WHEN e.Gender = 'M' THEN 'Male'
		ELSE 'Female' END AS 'Employee Gender',
	DATE_FORMAT(t.TransactionDate, '%d %M %y') AS 'Transaction Date', 
    t.CustomerName AS 'Customer Name'
FROM HeaderTransaction AS t
JOIN MsEmployee AS e
	ON t.EmployeeID = e.EmployeeID
WHERE e.EmployeeName LIKE '% %' AND e.Gender = 'M'
ORDER BY t.TransactionDate DESC;

-- Display columns Employee ID, EmployeeName, Date of Birth in dd-mm-yyyy format, 
-- CustomerName, and Transaction Date, all from the HeaderTransaction and Employee Tables
-- where the employee' birth month is 'December' and the Transaction Date day is above 16
SELECT 
	e. EmployeeID, e.EmployeeName AS 'Employee Name',
	DATE_FORMAT(e.DateOfBirth, '%d %m %y') AS 'Employee DOB',
    DATE_FORMAT(t.TransactionDate, '%D %M %Y') AS 'Transaction Date'
FROM HeaderTransaction AS t
JOIN MsEmployee AS e
	ON t.EmployeeID = e.EmployeeID
WHERE
	MONTHNAME(e.DateOfBirth) = 'December' 
	AND DAYOFMONTH(TransactiondATE) >= 16;

-- Common MySQL DATE_FORMAT rules for date month year: %d = 2-digit day (05), %D = day with suffix (5th), 
-- %m = 2-digit month (08), %M = full month name (August), %y = 2-digit year (25), and %Y = 4-digit year (2025).


