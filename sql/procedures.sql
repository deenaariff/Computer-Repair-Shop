--COEN178 Project
--procedures.sql
--Group: Deen and Maggie

Create or Replace Procedure newCustomer(n_name in VARCHAR, n_phone in VARCHAR)
AS
BEGIN
	Insert into Customer values(n_name, n_phone);
END;
/

Create or Replace Procedure acceptMachine(n_name in VARCHAR, model in VARCHAR, cId in VARCHAR, in_date in DATE)
AS

l_contract ServiceContract%rowtype;
l_phone Customers%type;

BEGIN

	Select * into l_contract
	From ServiceContract
	Where contractId = cId;

	Select phoneNo into l_phone
	From Customers
	Where name = n_name;

	IF to_date(in_date,'DD-MM-YYYY') >= l_contract.startDate
		AND to_date(in_date, 'DD-MM-YYYY') < l_contract.endDate THEN

		IF l_contract.itemId1 IS NULL THEN
			Update ServiceContract
			Set itemId1 = n_item, custPhone = l_phone
			Where cId = l_contract.contractId;

		IF n_item2 is NULL THEN
                	Insert into RepairItem values(n_item1, NULL, NULL, NULL, 'SINGLE', NULL);
        	ELSE
                	Insert into RepairItem values(n_item1, NULL, NULL, NULL, 'GROUP', NULL);
                	Insert into RepairItem values(n_item2, NULL, NULL, NULL, 'GROUP', NULL);
        	END IF;  
	ELSE
		DBMS_OUTPUT.put_line('Contract not valid');
		IF n_item2 is NULL THEN
                	Insert into RepairItem values(n_item1, NULL, NULL, NULL, 'NONE', NULL);
        	ELSE
                	Insert into RepairItem values(n_item1, NULL, NULL, NULL, 'NONE', NULL);
                	Insert into RepairItem values(n_item2, NULL, NULL, NULL, 'NONE', NULL);
        	END IF;
	END IF;
END;
/
Show errors;

Create or Replace Procedure newRepairJob(n_item in VARCHAr, cId in VARCHAR, cust in VARCHAR, emp inVARCHAR)
AS

BEGIN
	Insert into RepairJob values(n_item, cId, cust, emp, to_date(SYSDATE, 'DD-MM-YYYY'), 'UNDER_REPAIR');

END;
/
Show errors;

Create or Replace Procedure insertProblemCode(item in VARCHAR, code in INTEGER)
AS

BEGIN
	Insert into ProblemReport values(item, code, date);
END;
/
Show errors;	
