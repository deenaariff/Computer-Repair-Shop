--COEN178 Project
--Group: Deen and Maggie
--formatCustBill.sql

ACCEPT phone CHAR PROMPT 'Enter a customer phone number: '

PROMPT ****************************************************************

PROMPT
PROMPT
SET TERMOUT OFF
Column name NEW_VALUE cust_name
Column phoneNo NEW_VALUE cust_phone

Select * from Customers Where phoneNo = &phone;
SET TERMOUT ON

PROMPT &cust_name
PROMPT &cust_phone

PROMPT
PROMPT

SET TERMOUT OFF
Column model NEW_VALUE item_model
/*
TTITLE CENTER 'Customer Bill' skip 1 -
CENTER =============== skip 2
select * from repairjob;
*/
/*
--Rename Columns
Column itemId		Heading 'Item'
Column custPhone	Heading 'Phone'
Column timeOfArrival	Heading 'Time In'
Column laborHours	Heading 'Labor Hours'
Column costOfParts	Heading 'Cost of Parts'
Column total		Heading 'Total'
*/

