--COEN178 Project
--tables.sql
--Group: Deen and Maggie

DROP table CustomerBill;
DROP table ProblemReport;
DROP table RepairLog;
DROP table RepairJob;
DROP table RepairPerson;
DROP table ServiceContract;
DROP table RepairItem;
DROP table Customers;

--Create tables

Create Table Customers (
	phoneNo VARCHAR(14) Primary key,
	name VARCHAR(10)
);

Create Table RepairItem (
	itemId VARCHAR(10) Primary key,
	model VARCHAR(20),
	price NUMBER(6, 2),
	year NUMBER(4),
	contractType VARCHAR(6) Check (contractType in ('NONE','SINGLE','GROUP')),
	itemType VARCHAR(8) Check (itemType in ('COMPUTER', 'PRINTER'))
);

Create Table ServiceContract (
        contractId VARCHAR(10) Primary key,
        startDate DATE,
        endDate DATE,
        custPhone VARCHAR(14),
	itemId1 VARCHAR(5),
	itemId2 VARCHAR(5),
	contractType VARCHAR(6) Check (contractType in ('SINGLE','GROUP')),
        Foreign key (custPhone) references Customers(phoneNo),
	Foreign key (itemId1) references RepairItem(itemId),
	Foreign key (itemId2) references RepairITem(itemId)
);

Create Table RepairPerson (
	employeeNo VARCHAR(10) Primary key,
	empName VARCHAR(10),
	empPhone VARCHAR(14)
);

Create Table RepairJob (
	itemId VARCHAR(10),
	contractId VARCHAR(10),
	custPhone VARCHAR(14),
	empNo VARCHAR(10),
	timeOfArrival DATE,
	status VARCHAR(11) Check (status in ('UNDER_REPAIR','READY','DONE')),
	Foreign key (itemId) references RepairItem(itemId),
	Foreign key (contractId) references ServiceContract(contractId),
	Foreign key (custPhone) references Customers(phoneNo),
	Foreign key (empNo) references RepairPerson(employeeNo),
	Primary key(custPhone, timeOfArrival)
);

Create Table RepairLog (
	itemId VARCHAR(10),
        contractId VARCHAR(10),
        description VARCHAR(50),
        custPhone VARCHAR(14),
        empNo VARCHAR(14),
        timeOfArrival DATE,
	doneDate DATE,
        status VARCHAR(4) Check (status in ('DONE')),
        Foreign key (itemId) references RepairItem(itemId),
        Foreign key (contractId) references ServiceContract(contractId),
        Foreign key (custPhone) references Customers(phoneNo),
        Foreign key (empNo) references RepairPerson(employeeNo),
	Primary key(custPhone, doneDate)
);

Create Table ProblemReport (
	itemId VARCHAR(10),
	problemId INTEGER,
	timeOfArrival DATE,
	Foreign key (itemId) references RepairItem(itemId),
	Primary key(itemId, timeOfArrival) 
);	

Create Table CustomerBill (
	custPhone VARCHAR(14),
	timeOfArrival DATE,
	costOfParts NUMBER(5, 2),
	total NUMBER(5, 2),
	laborHours INTEGER,
	Foreign key (custPhone) references Customers(phoneNo),
	Primary key(custPhone, timeOfArrival)
);	
