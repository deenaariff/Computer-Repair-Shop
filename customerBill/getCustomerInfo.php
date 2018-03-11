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

	$row= oci_fetch_array($query,OCI_BOTH);
	$name = $row[0];
	echo "1, Customer Name " . $name;
	exit();

	/*if(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
		$name = $row[0];
	} else {
		echo "1, Invalid Customer Phone Number Provided " . $number;
		exit();
	}*/

	/* query for all the information in the customer bill */
	
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

	/* iterate over all repsonses that match */

	while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {

		// do a nother query here to get the model for a given item id

		$queryString2 = "SELECT model FROM RepairItem WHERE itemId = :id";

		$query2 = oci_parse($conn,$queryString);
		/* bind to the item id */
		oci_bind_by_name($query,':itemId',$row[0]);
		$res = oci_execute($query);

		if(!$res) {
			echo "1, Error in Database Query";
			exit();
		}

		/* push the model in to the model array */

		if(($row2=oci_fetch_array($query,OCI_BOTH)) != false) {
			array_push($models,$row2[0]);
		}

		/* push all other data into respective arrays */

		array_push($contracts,$row[1]);
		array_push($descriptions,$row[2]);
		array_push($dates,$row[3]);
	}

	/* serialize the data for consumption by the front-end */

	$contract_str = implode("|",$contracts);
	$model_str = implode("|",$models);
	$description_str = implode("|",$descriptions);
	$dates_str = implode("|",$dates);

	$arr = array ( 0 => $name, 1 => $number, 2 => $contract_str, 3 => $model_str, 4 => $description_str, 5 => $contract_date);
	$str = implode (",", $arr);
    echo "0," . $str;
}

?>