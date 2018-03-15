<?php

/*
Given the machine id or customer-phone or email address, should show a machine(s) status. 
*/

getRepairJobs();

function getRepairJobs()
{
	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	$queryString = "select * from table(getRepairJobs())";
	
	$query = oci_parse($conn,$queryString);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query ";
		exit();
	}

	$data = array();

	while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
		array_push($data,implode("|",$row));
	}

    echo "0," . implode(",",$data);
}

?>