<?php

/* query for a customer name given the customer phone number */
exit();

$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
if(!$conn) {
	echo "1, Error Connecting To Database";
	exit();
}


$queryString = "SELECT name,count(*) FROM (SELECT C.name, itemId FROM Customers C, RepairJob R WHERE C.phoneNo = R.custPhone) GROUP BY NAME";

$query = oci_parse($conn,$queryString);
$res = oci_execute($query);

if(!$res) {
	echo "1, Error in Database Query";
	exit();
}

$labels = array();
$data = array();

while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
	array_push($labels,$row[0]);
	array_push($data,$row[1]);
}

echo "0," . implode($labels,"|") . "," . implode($data,"|");

?>