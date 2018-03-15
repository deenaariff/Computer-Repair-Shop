<?php

$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
if(!$conn) {
	echo "1, Error Connecting To Database";
	exit();
}

/* query for a customer name given the customer phone number */

$queryString = "SELECT name,count(*) FROM (SELECT C.name, itemId FROM Customers C, RepairLog R WHERE C.phoneNo = R.custNo) GROUP BY NAME";

$query = oci_parse($conn,$queryString);
oci_bind_by_name($query,':phone',$number);
$res = oci_execute($query);

if(!$res) {
	echo "1, Error in Database Query";
	exit();
}

$labels = array();
$data = array();

while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
	array_push($labels,$row[0]);
	array_push($labels,$row[1]);
}

echo "0", implode($labels,"|") . "," . implode($data,"|");

?>