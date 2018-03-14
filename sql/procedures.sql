--COEN178 Project
--procedures.sql
--Group: Deen and Maggie

--Add a new customer
Create or Replace Procedure newCustomer(n_phone in VARCHAR, n_name in VARCHAR)
AS
BEGIN
	Insert into Customers values(n_phone, n_name);
	commit;
END;
/
Show errors;


-- Given the machine id or customer-phone or email address, should show a machine(s) status. 
Create or Replace Function showMachineStatus(i_id in VARCHAR, c_phone in VARCHAR)
	RETURN SYS_REFCURSOR
AS
  	my_cursor SYS_REFCURSOR;
BEGIN
	OPEN my_cursor FOR SELECT status FROM JOIN(RepairItem,RepairLOG)
		WHERE item_id = i_id OR custPhone = c_phone;
  	RETURN my_cursor;
END;
/
Show Errors

--Accept a new machine
Create or Replace Procedure acceptMachine(n_name in VARCHAR, n_item in VARCHAR, model in VARCHAR, cId in VARCHAR, in_date in DATE, message OUT VARCHAR2)

AS
Cursor Contract_cur is Select * from ServiceContract;

l_contract Contract_cur%rowtype;
l_name Customers.name%type := NULL;
l_phone Customers.phoneNo%type;
l_price RepairItem.price%type;
l_year RepairItem.year%type;
l_date DATE := to_date(in_date, 'DD-MM-YY');
l_cnt INTEGER := 0;

BEGIN
	Select count(*) into l_cnt
	From ServiceContract
	Where contractId = cId;

	IF l_cnt > 0 THEN
		Select * into l_contract
		From ServiceContract
		Where contractId = cId;
	END IF;

	Select count(*) into l_cnt
	From Customers
	Where phoneNo = phone;

	IF l_cnt = 0 THEN
		newCustomer(phone, n_name);
	END IF;
	
	l_price := dbms_random.value(700.00, 1500.00);
	l_year := dbms_random.value(2000, 2018);

	IF l_date >= l_contract.startDate AND l_date <= l_contract.endDate THEN
		
		IF l_contract.itemId1 is NULL THEN
			Insert into RepairItem values(n_item, model, l_price, l_year, l_contract.contractType, 'COMPUTER');
			
			Update ServiceContract
			Set itemId1 = n_item, custPhone = phone
			Where contractId = cId;

			Insert into RepairJob values(n_item, cId, phone, NULL, l_date, 'UNDER_REPAIR');
		ELSIF l_contract.itemId1 = n_item OR l_contract.itemId2 = n_item THEN
			Insert into RepairJob values(n_item, cId, phone, NULL, l_date, 'UNDER_REPAIR');
		ELSE
			IF l_contract.contractType = 'GROUP' AND l_contract.itemId2 is NULL THEN
				Insert into RepairItem values(n_item, model, l_price, l_year, l_contract.contractType, 'PRINTER');

				Update ServiceContract
				Set itemId2 = n_item
				Where contractId = cId;
				
				Insert into RepairJob values(n_item, cId, phone, NULL, l_date, 'UNDER_REPAIR');
			ELSE
				message :=  '1,Only one item allowed for Single contracts';
				Insert into RepairItem values(n_item, model, l_price, l_year, 'NONE', 'COMPUTER');
				Insert into RepairJob values(n_item, NULL, phone, NULL, l_date, 'UNDER_REPAIR');
			END IF;
		END IF;
	ELSE
		message := '1, Contract not valid';
	     	Insert into RepairItem values(n_item, model, l_price, l_year, 'NONE', 'COMPUTER');
		Insert into RepairJob values(n_item, NULL, phone, NULL, l_date, 'UNDER_REPAIR');
	END IF;
	
	Insert into CustomerBill values(n_item, phone, l_date, NULL, NULL, NULL);
	message := '0, Inserted into Record';
	commit;
END;
/
Show errors;

--Update a machine's repair status
Create or Replace Procedure updateMachineStatus(item in VARCHAR, n_status in VARCHAR)
AS
BEGIN
	Update RepairJob
	Set status = n_status
	Where itemId = item;

	commit;
END;
/
Show errors;

--Retrieve a machine's repair status
Create or Replace Function getMachineStatus(item in VARCHAR, phone in VARCHAR) return VARCHAR
AS

l_status RepairJob.status%type;

BEGIN
	Select status into l_status
	From RepairJob NATURAL JOIN RepairLog
	Where itemId = item or custPhone = phone;

	return l_status;
END;
/
Show errors;

Create or Replace Type job_Rec as object (
	itemId VARCHAR(10),
        contractId VARCHAR(10),
        custPhone VARCHAR(14),
        empNo VARCHAR(10),
        timeOfArrival DATE,
        status VARCHAR(12)
);
/
Create or Replace Type job_table as Table of job_rec;
/
Create or Replace Function getRepairJobs return job_table
AS
Cursor Job_cur is Select * from RepairJob;

l_job Job_cur%rowtype;
v_jobs job_table;

BEGIN
	v_jobs := job_table();

	For l_job in Job_cur
	loop
		IF l_job.status = 'UNDER_REPAIR' THEN
			v_jobs.extend;
			v_jobs(v_jobs.count) := job_rec(l_job.itemId, l_job.contractId,
							l_job.custPhone, l_job.empNo,
							l_job.timeOfArrival, l_job.status);
		END IF;
	END LOOP;
	
	return v_jobs;
END;
/
Show errors;

--Update the problem description for a machine
Create or Replace Procedure updateProblemDescrip(descrip in VARCHAR, item in VARCHAR, phone in VARCHAR, time in DATE)
AS
BEGIN
	Update RepairLog
	Set description = descrip
	Where custPhone = phone and doneDate = time and itemId = item;

	commit;
END;
/
Show errors;

--Delete finished job from RepairJob
Create or Replace Procedure deleteRepairJob(item in VARCHAR, phone in VARCHAR, time in DATE)
AS
BEGIN
	Delete from RepairJob
	Where itemId = item AND custPhone = phone AND timeOfArrival = time AND status = 'DONE';

	commit;
END;
/
Show errors;

--Get the total revenue generated
Create or Replace Function getRevenueGenerated(s_date in DATE, e_date in DATE) return NUMBER
AS
Cursor Bill_cur is
        Select * from CustomerBill;
Cursor Log_cur is
        Select * from RepairLog;

l_bill Bill_cur%rowtype;
l_log Log_cur%rowtype;
l_revenue NUMBER(6,2) := 0.00;

BEGIN
        for l_log in Log_cur
        loop
                IF l_log.timeOfArrival >= s_date AND l_log.doneDate <= e_date THEN
                        For l_bill in Bill_cur
                        loop
                                IF l_bill.custPhone = l_log.custPhone AND l_bill.timeOfArrival = l_log.timeOfArrival AND l_bill.itemId = l_log.itemId THEN
                                        l_revenue := l_revenue + l_bill.total;
                                END IF;
                        END LOOP;
                END IF;
        END LOOP;

	return l_revenue;
END;
/
Show errors;

--Get the total revenue generated from machines with no warranty
Create or Replace Function getRevenueNoWarranty(s_date in DATE, e_date in DATE) return NUMBER
AS

Cursor Bill_cur is
        Select * from CustomerBill;
Cursor Log_cur is
        Select * from RepairLog;

l_bill Bill_cur%rowtype;
l_log Log_cur%rowtype;
l_revenue NUMBER(6,2) := 0.00;

BEGIN
        for l_log in Log_cur
        loop
                IF l_log.timeOfArrival >= s_date AND l_log.doneDate <= e_date AND l_log.contractId IS NULL THEN
                        For l_bill in Bill_cur
                        loop
                                IF l_bill.custPhone = l_log.custPhone AND l_bill.timeOfArrival = l_log.timeOfArrival AND l_bill.itemId = l_log.itemId THEN
                                        l_revenue := l_revenue + l_bill.total;
                                END IF;
                        END LOOP;
                END IF;
        END LOOP;

	return l_revenue;
END;
/
Show errors;

--Get the total revenue from machines covered by warranty
Create or Replace Function getRevenueWarranty(s_date in DATE, e_date in DATE) return NUMBER
AS
Cursor Bill_cur is
	Select * from CustomerBill;
Cursor Log_cur is
	Select * from RepairLog;

l_bill Bill_cur%rowtype;
l_log Log_cur%rowtype;
l_revenue NUMBER(6,2) := 0.00;

BEGIN
	for l_log in Log_cur
	loop
		IF l_log.timeOfArrival >= s_date AND l_log.doneDate <= e_date AND l_log.contractId IS NOT NULL THEN
			For l_bill in Bill_cur
			loop
				IF l_bill.custPhone = l_log.custPhone AND l_bill.timeOfArrival = l_log.timeOfArrival AND l_bill.itemId = l_log.itemId THEN
					l_revenue := l_revenue + 50 + l_bill.costOfParts + (l_bill.laborHours * 20);
				END IF;
			END LOOP;
		END IF;
	END LOOP;

	return l_revenue;
END;
/
Show errors;

