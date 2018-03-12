--COEN178 Project
--Group: Deen and Maggie
--triggers.sql

Create or Replace TRIGGER RepairJob_after_update_trig
After UPDATE Of status ON RepairJob
	FOR EACH ROW
DECLARE
	Cursor Job_cur is Select * from RepairJob;
	v_job Job_cur%rowtype;
	v_contractType RepairItem.contractType%type;

BEGIN
	Select * into v_job
	From RepairJob
	Where custPhone = :new.custPhone AND timeOfArrival = :new.timeOfArrival;

	IF v_job.status = 'DONE' THEN
		Insert into RepairLog values(v_job.itemId, v_job.contractId, NULL, v_job.custPhone,
			v_job.custPhone, v_job.empNo, v_job.timeOfArrival,
			to_date(SYSDATE, 'DD-MM-YY'), v_job.status);

		Delete From RepairJob Where custPhone = v_job.custPhone AND timeOfArrival = v_job.timeOfArrival AND itemId = v_job.itemId;
		
		Select contractType into v_contractType
		From RepairItem
		Where v_job.itemId = itemId;

		IF v_contractType = 'NONE' THEN
			Update CustomerBill
			Set laborHours = DBMS_RANDOM.value(1, 10), costOfParts = DBMS_RANDOM.value(10.00, 30.00),
				total = 50 + costOfParts + (laborHours * 20)
			Where custPhone = v_job.custPhone AND timeOfArrival = v_job.timeOfArrival;
		ELSE
			Update CustomerBill
			Set laborHours = DBMS_RANDOM.value(1, 10), costOfParts = DBMS_RANDOM.value(10.00, 30.00),
				total = 0
			Where custPhone = v_job.custPhone AND timeOfArrival = v_job.timeOfArrival;
		END IF;
	END IF;
END;
/
Show errors;
