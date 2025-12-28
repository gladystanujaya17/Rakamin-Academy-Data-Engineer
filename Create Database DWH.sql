CREATE DATABASE DWH
GO

USE DWH

-- Membuat DimBranch
CREATE TABLE DimBranch (
	BranchID INT NOT NULL PRIMARY KEY,
	BranchName VARCHAR(50),
	BranchLocation VARCHAR(50)
);

-- Membuat DimCustomer
CREATE TABLE DimCustomer (
	CustomerID INT PRIMARY KEY,
	CustomerName VARCHAR(50),
	Address TEXT,
	CityName VARCHAR(50),
	StateName VARCHAR(50),
	Age VARCHAR(3),
	Gender VARCHAR(10),
	Email VARCHAR(50)
);

-- Membuat DimAccount
CREATE TABLE DimAccount (
	AccountID INT NOT NULL PRIMARY KEY,
	CustomerID INT,
	AccountType VARCHAR(10),
	Balance INT,
	DateOpened DATETIME2(0),
	status VARCHAR(10),
	-- FK ke DimCustomer melalui field customer_id di DimCustomer
	CONSTRAINT FK_DimAccount_DimCustomer 
		FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID) 
);

-- Membuat FactTransaction
CREATE TABLE FactTransaction (
	TransactionID INT NOT NULL PRIMARY KEY,
	AccountID INT,
	TransactionDate DATETIME2(0),
	Amount INT, 
	TransactionType VARCHAR(50),
	BranchID INT,
	-- FK ke DimAccount melalui field account_id di DimAccount
	CONSTRAINT FK_FactTransaction_DimAccount
		FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID),
	-- FK ke DimBranch melalui field branch_id di DimBranch
	CONSTRAINT FK_FactTransaction_DimBranch
		FOREIGN KEY (BranchID) REFERENCES DimBranch(BranchID)
);