--- Tests for Customer Bill
start tables;

INSERT INTO Customers VALUES ('408-663-7143','Deen Aarif');
INSERT INTO RepairItem VALUES ('001','Samsung',40.00,2017,'SINGLE','COMPUTER');
INSERT INTO CustomerBill VALUES ('001','408-663-7143',DATE '2015-12-17',20.00,40.00,5);
INSERT INTO ServiceContract VALUES('S01',DATE '2015-12-10',DATE '2015-12-17','408-663-7143','001',NULL,'SINGLE');
INSERT INTO RepairPerson VALUES('e01','john smith','408-666-6666');
INSERT INTO RepairLog VALUES('001','S01','No Problems','408-663-7143','e01',DATE '2015-12-10',DATE '2015-12-17','DONE');


--declare
--	msg  VARCHAR2(20) := '';
--begin
--	acceptMachine('Deen Aarif','408-663-7143','002','Samsung',DATE '2015-12-11',msg);
--end;
--/

declare
	output number := 0;
begin
	output := getRevenueGenerated(DATE '2015-12-8', DATE '2015-12-17');
	dbms_output.put_line('Result : ' || output);
end;
/

commit;
