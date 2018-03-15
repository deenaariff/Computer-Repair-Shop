<?php

/* query for a customer name given the customer phone number */

$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
if(!$conn) {
	echo "1, Error Connecting To Database";
	exit();
}


$queryString = "SELECT itemID, contractID, custPhone, empNo, timeOfArrival, DONEDATE FROM RepairLog";

$query = oci_parse($conn,$queryString);
$res = oci_execute($query);

if(!$res) {
	echo "1, Error in Database Query";
	exit();
}

$rows = array();

while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
	$entry = $row[0] . "|" . $row[2] . "|" . $row[3] . "|" . $row[4] . "|" . $row[5];
	array_push($rows,$entry);
}

echo "0," . implode($row,",");

?>