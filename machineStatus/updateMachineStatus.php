<?php

/*
Given the machine id or customer-phone or email address, should show a machine(s) status. 
*/

if(!isset($_GET['m_id']) && !isset($_GET['status'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = $_GET['m_id'];
$arg2 = $_GET['status'];

updateMachineStatus($arg1, $arg2);

/*updateMachineStatus(item in VARCHAR, n_status in VARCHAR)*/
function updateMachineStatus($machine_id, $status)
{
	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	$queryString = "BEGIN updateMachineStatus(:id, :status); END;";
	
	$query = oci_parse($conn,$queryString);

	oci_bind_by_name($query,':id', $machine_id);
	oci_bind_by_name($query,':status',$status);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query ";
		exit();
	}

    echo "0," . "Succesful Update";
}

?>