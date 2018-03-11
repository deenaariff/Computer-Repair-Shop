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
l_phone Customers.phoneNo%type;
l_price RepairItem.price%type;
l_year RepairItem.year%type;

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

			Insert into RepairItem values(n_item, model, l_price, l_year, l_contract.contractType, 'COMPUTER');
			Insert into RepairJob values(n_item, l_contract.contractId, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YYYY'), 'UNDER_REPAIR');
		ELSE
			IF l_contract.contractType = 'GROUP' THEN
				Update ServiceContract
				Set itemId2 = n_item, custPhone = l_phone
				Where cId = l_contract.contractId;
				
				Insert into RepairItem values(n_item, model, l_price, l_year, l_contract.contractType, 'PRINTER');
				Insert into RepairJob values(n_item, l_contract.contractId, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YYYY'), 'UNDER_REPAIR');
			ELSE
				DBMS_OUTPUT.put_line('Error: Only one item allowed for Single contracts');
				Insert into RepairItem values(n_item, model, l_price, l_year, 'NONE', 'COMPUTER');
				Insert into RepairJob values(n_item, NULL, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YYYY'), 'UNDER_REPAIR');
			END IF;
		END IF;
	ELSE
		DBMS_OUTPUT.put_line('Contract not valid');
     		Insert into RepairItem values(n_item, model, l_price, l_year, 'NONE', 'COMPUTER');
		Insert into RepairJob values(n_item, NULL, l_phone, NULL, to_date(SYSDATE, 'DD-MM-YYYY'), 'UNDER_REPAIR');
	END IF;

END;
/
Show errors;

Create or Replace Procedure updateMachineStatus(item in VARCHAR, n_status in VARCHAR)
AS
BEGIN
	Update RepairJob
	Set status = n_status
	Where itemId = item;
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
