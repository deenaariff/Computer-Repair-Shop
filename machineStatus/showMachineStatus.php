<?php

/*
Given the machine id or customer-phone or email address, should show a machine(s) status. 
*/

if(!isset($_GET['m_id']) && !isset($_GET['phone'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = $_GET['m_id'];
$arg2 = $_GET['phone'];

echo "1,break1";
showMachineStatus($arg1, $arg2);

function showMachineStatus($machine_id, $number)
{
	/*$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	$subquery = "";*/
	$str = "";
	/*$queryString = 'BEGIN :res := getMachineStatus(:id,:number); END;';

	echo "1, Break2";
	
	$query = oci_parse($conn,$queryString);

	oci_bind_by_name($query,':res', $str);
	oci_bind_by_name($query,':id', $machine_id);
	oci_bind_by_name($query,':number',$number);

	echo "1, Break3";

	$res = oci_execute($query);

	echo "1, Break4";

	if(!$res) {
		echo "1, Error in Database Query";
		exit();
	}*/

    echo "0," . $str;
}

?>