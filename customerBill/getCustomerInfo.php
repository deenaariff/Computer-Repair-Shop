<?php

if(!isset($argv[1]) && !isset($_GET['number'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = '';

if(isset($argv[1])) $arg1 = $argv[1];
if(isset($_GET['number'])) $arg1 = $_GET['number'];

getCustInfo($arg1);

function getCustInfo($number)
{
	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	/* query for a customer name given the customer phone number */

	$queryString = "SELECT name FROM Customers WHERE phoneNo=:phone";

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
	
	$queryString = "SELECT itemId, contractId, description, timeOfArrival FROM RepairLog WHERE custPhone = :phone";

	$query = oci_parse($conn,$queryString);
	oci_bind_by_name($query,':phone',$number);
	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query";
		exit();
	}

	/* creates arrays for storing data before serialization */
	$models = array();
	$contracts = array();
	$dates = array();
	$descriptions = array();
	$prices = array();
	$total = 0;

	if(($row=oci_fetch_array($query,OCI_BOTH)) == false) {
		echo "1, Customer is Not Billed for this number: " . $number;
		exit();
	}

	/* iterate over all repsonses that match */

	while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {

		// do a nother query here to get the model for a given item id
		$itemId = $row[0];

		echo "1",$itemId;

		$queryString2 = "SELECT model FROM RepairItem WHERE itemId = :itemId";

		$query2 = oci_parse($conn,$queryString2);
		/* bind to the item id */
		oci_bind_by_name($query2,':itemId',$itemId);
		$res = oci_execute($query2);

		if(!$res) {
			echo "1, Error in Database Query";
			exit();
		}

		/* push the model in to the model array */

		if(($row2=oci_fetch_array($query2,OCI_BOTH)) != false) {
			array_push($models,$row2[0]);
		}

		/* push all other data into respective arrays */

		if(array_key_exists(1,$row)) {	
			array_push($contracts,$row[1]);	
		} else {
			array_push($contracts,"NO CONTRACT");
		}
		
		array_push($descriptions,$row[2]);
		array_push($dates,$row[3]);

		/* serialize the data for consumption by the front-end */
		$queryString = "SELECT total FROM CustomerBill WHERE itemId = :itemId";

		$query3 = oci_parse($conn,$queryString);
		oci_bind_by_name($query3,':itemId',$itemId);
		$res = oci_execute($query3);

		if(!$res) {
			echo "1, Error in Database Query for customer total in Customer Bill";
			exit();
		}

		if(($row3=oci_fetch_array($query3,OCI_BOTH)) != false) {
			$total = $total + (int)$row3[0];
			array_push($prices,(int)$row3[0]);
		}

		if(array_key_exists(1,$row)) {
			array_push($contracts,$row[1]);
		} else {
			array_push($contracts,"NO CONTRACT");
		}

		array_push($descriptions,$row[2]);
		array_push($dates,$row[3]);

	}


	$contract_str = implode("|",$contracts);
	$model_str = implode("|",$models);
	$description_str = implode("|",$descriptions);
	$dates_str = implode("|",$dates);	
	$price_str = implode("|",$prices);

	$arr = array ( 0 => $name, 1 => $number, 2 => $contract_str, 3 => $model_str, 4 => $description_str, 5 => $dates_str, 6 => $total, 7 => $price_str);

	$str = implode (",", $arr);
    echo "0," . $str;
}

?>