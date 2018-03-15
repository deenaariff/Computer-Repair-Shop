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

showMachineStatus($arg1, $arg2);

function showMachineStatus($machine_id, $number)
{
	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	$queryString = "select * from table(showMachineStatus(:id,:number))";
	
	$query = oci_parse($conn,$queryString);

	oci_bind_by_name($query,':res', $str, 22, SQLT_CHR);
	oci_bind_by_name($query,':id', $machine_id);
	oci_bind_by_name($query,':number',$number);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query ";
		exit();
	}

	$str = "";

    while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
		//echo json_encode($row);
		$str = $str . $row[0] . "is" . $row[1] . ". ";
	};

	echo "0, " . $str
}

?>