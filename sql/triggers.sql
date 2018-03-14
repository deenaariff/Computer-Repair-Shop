--COEN178 Project
--Group: Deen and Maggie
--triggers.sql

--Trigger inserts finished job into RepairLog then deletes the job from RepairJob
Create or Replace TRIGGER finished_job_trig
FOR UPDATE ON RepairJob
COMPOUND TRIGGER

v_status RepairJob.status%type;
v_item RepairJob.itemId%type;
v_phone RepairJob.custPhone%type;
v_time RepairJob.timeOfArrival%type;

BEFORE EACH ROW IS
BEGIN
        v_item := :new.itemId;
        v_phone := :new.custPhone;
        v_time := :new.timeOfArrival;
END BEFORE EACH ROW;

AFTER EACH ROW IS
BEGIN
        v_status := :new.status;
        IF v_status = 'DONE' THEN
                Insert into RepairLog values(:new.itemId, :new.contractId, NULL,
                        :new.custPhone, :new.empNo, :new.timeOfArrival,
                        to_date(SYSDATE, 'DD-MM-YY'), v_status);
        END IF;
END AFTER EACH ROW;

AFTER STATEMENT IS
BEGIN
        Delete From RepairJob
        Where itemId = v_item AND custPhone = v_phone AND timeOfArrival = v_time AND status = 'DONE';
END AFTER STATEMENT;
END;
/
Show errors;

--Update CustomerBill costs after job is ready
Create or Replace TRIGGER update_CustomerBill_trig
After UPDATE of status ON RepairJob
	FOR EACH ROW
DECLARE
	v_status RepairJob.status%type;
	v_contractType RepairItem.contractType%type;
	l_hours INTEGER;
	l_parts NUMBER(4, 2);
BEGIN
	v_status := :new.status;
	IF v_status = 'READY' THEN
		Select contractType into v_contractType
		From RepairItem
		Where itemId = :new.itemId;
	
		l_hours := DBMS_RANDOM.value(1, 10);
		l_parts := DBMS_RANDOM.value(10.00, 30.00);

		IF v_contractType = 'NONE' THEN
			Update CustomerBill
			Set laborHours = l_hours, costOfParts = l_parts,
				total = (50 + l_parts + (l_hours * 20))
			Where custPhone = :new.custPhone AND timeOfArrival = :new.timeOfArrival
				AND itemId = :new.itemId;
		ELSE
			Update CustomerBill
			Set laborHours = l_hours, costOfParts = l_parts,
				total = 0
			Where custPhone = :new.custPhone AND timeOfArrival = :new.timeOfArrival
				AND itemId = :new.itemId;
		END IF;
	END IF;
END;
/
Show errors;

