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


	$queryString = "SELECT * FROM table(getRepairJobs());";
	
	$query = oci_parse($conn,$queryString);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query ";
		exit();
	}

	while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
		echo "1", $row[0];
	}

    echo "0," . $str;
}

?>