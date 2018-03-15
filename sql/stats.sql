--- Tests for Customer Bill
@tables
@procedures
@triggers

--INSERT INTO Customers VALUES ('408-663-7143','Deen Aarif');
INSERT INTO ServiceContract VALUES('S01',DATE '2018-02-01',DATE '2018-02-02','111-111-1111',NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S02',DATE '2018-02-01',DATE '2018-02-02','222-222-2222,NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S03',DATE '2018-02-01',DATE '2018-02-02','111-111-1111',NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S04',DATE '2018-02-01',DATE '2018-02-02','333-333-3333',NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S05',DATE '2018-02-01',DATE '2018-02-02','333-333-3333',NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S06',DATE '2018-02-01',DATE '2018-02-02','444-444-4444',NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S07',DATE '2018-02-01',DATE '2018-02-02','666-666-6666',NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S08',DATE '2018-02-01',DATE '2018-02-02','555-555-5555',NULL,NULL,'SINGLE');
INSERT INTO ServiceContract VALUES('S09',DATE '2018-02-01',DATE '2018-02-02','222-222-2222',NULL,NULL,'SINGLE');
INSERT INTO RepairPerson VALUES('e01','Dumbledore','408-666-6666');

declare
	msg  VARCHAR2(60);
begin
	acceptMachine('Voldy','111-111-1111','001','Elder Wand', 'S01', DATE '2018-03-01',msg);
	acceptMachine('Harry P','222-222-2222','002','Cloak', 'S02', DATE '2018-03-02',msg);
	acceptMachine('Voldy','111-111-1111','003','Horcruxs', 'S03', DATE '2018-03-03',msg);
	acceptMachine('Herm G','333-333-3333','004','SPUM', 'S04', DATE '2018-03-05',msg);
	acceptMachine('Herm G','333-333-3333','005','Crookshanks', 'S05', DATE '2018-03-08',msg);
	acceptMachine('Ron W','444-444-4444','006','Scabbers', 'S06', DATE '2018-03-010',msg);
	acceptMachine('Severus S','666-666-6666','007','Potion', 'S07', DATE '2018-03-011',msg);
	acceptMachine('Ginny W','555-555-5555','008','Broomstick', 'S08', DATE '2018-03-13',msg);
	acceptMachine('Harry P','111-111-1111','009','Firebolt', 'S09', DATE '2018-03-16',msg);

	updateMachineStatus('001','READY');
	updateMachineStatus('001','DONE');

	updateMachineStatus('002','READY');
	updateMachineStatus('002','DONE');

	updateMachineStatus('003','READY');
	updateMachineStatus('003','DONE');

	updateMachineStatus('004','READY');
	updateMachineStatus('004','DONE');

	updateMachineStatus('006','READY');
	updateMachineStatus('006','DONE');

	updateMachineStatus('007','READY');
	updateMachineStatus('007','DONE');

	updateMachineStatus('009','READY');
	updateMachineStatus('009','DONE');

end
/




commit;
