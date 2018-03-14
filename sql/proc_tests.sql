--Procedure tests

--Test newCustomer
execute newCustomer('408-828-3360', 'Maggie');
execute newCustomer('123-456-7890', 'John Doe');
execute newCustomer('000-111-2222', 'Sally');

--Insert new values into tables
Insert into ServiceContract values('S02', DATE '2018-01-01', DATE '2018-06-01', NULL, NULL, NULL, 'SINGLE');
Insert into ServiceContract values('S03', DATE '2018-01-01', DATE '2018-06-01', NULL, NULL, NULL, 'GROUP');
Insert into ServiceContract values('S04', DATE '2017-01-01', DATE '2017-03-01', NULL, NULL, NULL, 'SINGLE');

--Test acceptMachine
declare
	msg VARCHAR2(60);
BEGIN
	--Test Single contract
	acceptMachine('Maggie', '408-828-3360','003','Apple', 'S02', DATE '2018-03-13', msg);
	acceptMachine('Maggie', '408-828-3360','004','Apple', 'S02', DATE '2018-03-13', msg);

	--Test Group contract
	acceptMachine('John Doe', '123-456-7890','005','Windows', 'S03', DATE '2018-03-13', msg);
	acceptMachine('John Doe', '123-456-7890','006','Android','S03',DATE '2018-03-13', msg); 
	
	--Test contract not valid
	acceptMachine('Sally', '000-111-2222','007','Windows','S04', DATE '2018-03-13', msg);
	acceptMachine('Sally', '000-1112222','008','Samsung','S05', DATE '2018-03-10', msg);

	--Test new customer
	acceptMachine('Bob','123-123-1234','009','Samsung',NULL, DATE '2018-03-13', msg);
END;
/
Show errors;

--Test updateMachineStatus
execute updateMachineStatus('003', 'READY');
execute updateMachineStatus('004', 'READY');
execute updateMachineStatus('005', 'READY');
execute updateMachineStatus('006', 'READY');
execute updateMachineStatus('004', 'DONE');
execute updateMachineStatus('005', 'DONE');
execute updateMachineStatus('006', 'DONE');

--Test getMachineStatus
Select getMachineStatus('003', '408-828-3360') from dual;
Select getMachineStatus('005', '123-456-7890') from dual;
Select getMachineStatus('007', '000-111-2222') from dual;

--Test getRepairJobs
Select * from table(getRepairJobs);

--Test updateProblemDescription
execute updateProblemDescrip('problem 1','004','408-828-3360',DATE '2018-03-13');

--Test deleteRepairJob
--execute deleteRepairJob('004','408-828-3360',DATE '2018-03-13');
--execute deleteRepairJob('003','408-828-3360',DATE '2018-03-13');

--Test getRevenueGenerated
Select getRevenueGenerated(DATE '2018-01-01',DATE '2018-12-31') from dual;
Select getRevenueGenerated(DATE '2017-01-01',DATE '2017-12-31') from dual;

--Test getRevenueNoWarranty
Select getRevenueNoWarranty(DATE '2018-01-01',DATE '2018-12-31') from dual;

--Test getRevenueWarranty
Select getRevenueWarranty(DATE '2018-01-01',DATE '2018-12-31') from dual;
