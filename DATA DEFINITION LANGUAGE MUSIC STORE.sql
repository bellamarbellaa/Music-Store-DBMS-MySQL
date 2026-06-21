-- Create database
CREATE DATABASE MusicStore;

-- Use database
USE MusicStore;

-- Table MsBranch stores branch data
CREATE TABLE MsBranch (
    BranchID VARCHAR(5) PRIMARY KEY,
    BranchName VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),

    CONSTRAINT chk_branch_id
    CHECK (BranchID REGEXP '^BR[0-9]{3}$')
);

-- Table MsEmployee stores employee data
CREATE TABLE MsEmployee (
    EmployeeID VARCHAR(5) PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    EmployeeAddress VARCHAR(100) NOT NULL,
    EmployeePhone VARCHAR(20),
    Gender CHAR(1) NOT NULL,
    DOB DATE NOT NULL,
    Salary INT NOT NULL,
    BranchID VARCHAR(5) NOT NULL,

    CONSTRAINT chk_employee_id
    CHECK (EmployeeID REGEXP '^EM[0-9]{3}$'),

    CONSTRAINT chk_gender
    CHECK (Gender IN ('M','F')),

    CONSTRAINT FK_employee_branch
    FOREIGN KEY (BranchID) REFERENCES MsBranch(BranchID)
    ON UPDATE CASCADE ON DELETE SET NULL
);

-- Table MsMusicInsType stores music instrument types
CREATE TABLE MsMusicInsType (
    MusicInsTypeID VARCHAR(5) PRIMARY KEY,
    MusicInsTypeName VARCHAR(50) NOT NULL,

    CONSTRAINT chk_musicInsType_id
    CHECK (MusicInsTypeID REGEXP '^MT[0-9]{3}$')
);

-- Table MsMusicIns stores music instrument data
CREATE TABLE MsMusicIns (
    MusicInsID VARCHAR(5) PRIMARY KEY,
    MusicInsName VARCHAR(100) NOT NULL,
    Price INT NOT NULL,
    Stock INT NOT NULL,
    MusicTypeID VARCHAR(5) NOT NULL,

    CONSTRAINT chk_music_ins_id
    CHECK (MusicInsID REGEXP '^MI[0-9]{3}$'), 
    -- REGEXP means that the value must match a specific text pattern
    -- must begin with MI, must include exactly 3 digits where each digit is anywhere between 0-9, $ end of text

    CONSTRAINT chk_musicIns_price
    CHECK (Price > 0),

    CONSTRAINT chk_musicIns_stock
    CHECK (Stock >= 0),

    CONSTRAINT FK_musicIns_musicInsType
    FOREIGN KEY (MusicTypeID) REFERENCES MsMusicType(MusicTypeID)
);

-- Table HeaderTransaction stores transaction header data
CREATE TABLE HeaderTransaction (
    TransactionID VARCHAR(5) PRIMARY KEY,
    TransactionDate DATETIME NOT NULL,
    EmployeeID VARCHAR(5) NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,

    CONSTRAINT chk_transaction_id
    CHECK (TransactionID REGEXP '^TR[0-9]{3}$'),

    CONSTRAINT FK_transaction_employee
    FOREIGN KEY (EmployeeID) REFERENCES MsEmployee(EmployeeID)
    ON UPDATE CASCADE ON DELETE SET NULL
);

-- Table DetailTransaction stores transaction detail data
CREATE TABLE DetailTransaction (
    TransactionID VARCHAR(5) REFERENCES HeaderTransaction(TransactionID),
    MusicInsID VARCHAR(5) REFERENCES MsMusicIns(MusicInsID), 
    Qty INT NOT NULL,

    CONSTRAINT PK_detail_transaction
    PRIMARY KEY (TransactionID, MusicInsID),

    CONSTRAINT chk_detailTransQty
    CHECK (Qty >= 0)
); 

-- Altering Table Example
ALTER TABLE MsEmployee
ADD Email VARCHAR(100);

ALTER TABLE MsEmployee
DROP Email;


