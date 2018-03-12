--COEN178 Project
--procedures.sql
--Group: Deen and Maggie

Create or Replace Procedure newCustomer(n_name in VARCHAR, n_phone in VARCHAR)
AS
BEGIN
	Insert into Customers values(n_phone, n_name);
	commit;
END;
/
Show errors;

Create or Replace Procedure acceptMachine(n_name in VARCHAR, n_item in VARCHAR, model in VARCHAR, cId in VARCHAR, in_date in DATE)
AS

l_contract ServiceContract%rowtype;
l_phone Customers.phoneNo%type;
l_price RepairItem.price%type;
l_year RepairItem.year%type;
l_date DATE := to_date(in_date, 'DD-MM-YY');

BEGIN

	Select * into l_contract
	From ServiceContract
	Where contractId = cId;

	Select phoneNo into l_phone
	From Customers
	Where name = n_name;

	IF l_date >= l_contract.startDate
		AND l_date < l_contract.endDate THEN

		IF l_contract.itemId1 IS NULL THEN
			Update ServiceContract
			Set itemId1 = n_item, custPhone = l_phone
			Where cId = l_contract.contractId;

			Insert into RepairItem values(n_item, model, l_price, l_year, l_contract.contractType, 'COMPUTER');
			Insert into RepairJob values(n_item, l_contract.contractId, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YY'), 'UNDER_REPAIR');
		ELSE
			IF l_contract.contractType = 'GROUP' THEN
				Update ServiceContract
				Set itemId2 = n_item, custPhone = l_phone
				Where cId = l_contract.contractId;
				
				Insert into RepairItem values(n_item, model, l_price, l_year, l_contract.contractType, 'PRINTER');
				Insert into RepairJob values(n_item, l_contract.contractId, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YY'), 'UNDER_REPAIR');
			ELSE
				DBMS_OUTPUT.put_line('Error: Only one item allowed for Single contracts');
				Insert into RepairItem values(n_item, model, l_price, l_year, 'NONE', 'COMPUTER');
				Insert into RepairJob values(n_item, NULL, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YY'), 'UNDER_REPAIR');
			END IF;
		END IF;
	ELSE
		DBMS_OUTPUT.put_line('Contract not valid');
     		Insert into RepairItem values(n_item, model, l_price, l_year, 'NONE', 'COMPUTER');
		Insert into RepairJob values(n_item, NULL, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YY'), 'UNDER_REPAIR');
	END IF;
	
	Insert into CustomerBill values(l_phone, l_date, NULL, NULL, NULL);
	commit;
END;
/
Show errors;

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

Create or Replace Function getMachineStatus(item in VARCHAR, phone in VARCHAR) return VARCHAR
AS

l_status RepairJob.status%type;

BEGIN
	Select status into l_status
	From RepairJob
	Where itemId = item and custPhone = phone;

	return l_status;
END;
/
Show errors;

Create or Replace Procedure updateProblemDescrip(descrip in VARCHAR, phone in VARCHAR, time in DATE)
AS
BEGIN
	Update RepairLog
	Set description = descrip
	Where custPhone = phone and doneDate = time;
END;
/
Show errors;

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
                                IF l_bill.custPhone = l_log.custPhone AND l_bill.timeOfArrival = l_log.timeOfArrival THEN
                                        l_revenue := l_revenue + l_bill.total;
                                END IF;
                        END LOOP;
                END IF;
        END LOOP;

	return l_revenue;
END;
/
Show errors;

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
                IF l_log.timeOfArrival >= s_date AND l_log.doneDate <= e_date AND l_log.contractID IS NULL THEN
                        For l_bill in Bill_cur
                        loop
                                IF l_bill.custPhone = l_log.custPhone AND l_bill.timeOfArrival = l_log.timeOfArrival THEN
                                        l_revenue := l_revenue + l_bill.total;
                                END IF;
                        END LOOP;
                END IF;
        END LOOP;

	return l_revenue;
END;
/
Show errors;

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
		IF l_log.timeOfArrival >= s_date AND l_log.doneDate <= e_date AND l_log.contractID IS NOT NULL THEN
			For l_bill in Bill_cur
			loop
				IF l_bill.custPhone = l_log.custPhone AND l_bill.timeOfArrival = l_log.timeOfArrival THEN
					l_revenue := l_revenue + 50 + l_bill.costOfParts + (l_bill.laborHours * 20);
				END IF;
			END LOOP;
		END IF;
	END LOOP;

	return l_revenue;
END;
/
Show errors;

