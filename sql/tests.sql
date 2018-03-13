--- Tests for Customer Bill
start tables;
start procedures;

INSERT INTO Customers VALUES ('408-663-7143','Deen Aarif');
INSERT INTO CustomerBill VALUES ('408-663-7143',DATE '2015-12-17',20.00,40.00,5);
INSERT INTO RepairItem VALUES ('001','Samsung',40.00,2017,'SINGLE','COMPUTER');
INSERT INTO ServiceContract VALUES('S01',DATE '2015-12-10',DATE '2015-12-17','408-663-7143','001',NULL,'SINGLE');
INSERT INTO RepairPerson VALUES('e01','john smith','408-666-6666');
INSERT INTO RepairLog VALUES('001','S01','No Problems','408-663-7143','e01',DATE '2015-12-10',DATE '2015-12-17','DONE');

EXECUTE acceptMachine('d','s','408-663-7143','','');

commit;