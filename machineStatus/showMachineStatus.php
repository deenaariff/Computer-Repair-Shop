<?php

/*
Given the machine id or customer-phone or email address, should show a machine(s) status. 
*/

if(!isset($_GET['m_id']) && !isset($_GET['customer_phone'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = 'unset'

if(!isset($_GET['m_id'])) {
	$arg1 = $_GET['m_id'];
}

if(!isset($_GET['customer_phone']) {
	$arg2 = $_GET['customer_phone'];
}

showMachineStatus($arg1,$arg2);

function showMachineStatus($machine_id, $cust_phone)
{
	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	$subquery = "";

	/* query for a customer name given the customer phone number */
	if($machine_id != 'unset') {
		$queryString = "SELECT name FROM JOIN(RepairJob,RepairLog) WHERE itemId=:phone";
	} else {
		$queryString = "SELECT name FROM Customers WHERE phoneNo=:phone";
		$query = oci_parse($conn,$queryString);
		oci_bind_by_name($query,':phone',$number);
	}

	$queryString  = "SELECT model FROM RepairItem WHERE itemId IN (" . $subquery . ")";
	
	$query = oci_parse($conn,$queryString);
	oci_bind_by_name($query,':phone',$number);
	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query";
		exit();
	}

	if(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
		$name = $row[0];
	} else {
		echo "1, Invalid Customer Phone Number Provided: " . $number;
		exit();
	}

	$str = implode (",", $arr);
    echo "0," . $str;
}

?>