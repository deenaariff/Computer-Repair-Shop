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

	$p_cursor = oci_new_cursor($conn);

	$queryString = "BEGIN :curs := getRepairJobs(); END;";
	
	$query = oci_parse($conn,$queryString);

	oci_bind_by_name($query,':curs', $p_cursor, -1, OCI_B_CURSOR);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query ";
		exit();
	}

	oci_execute($p_cursor);  // Execute the REF CURSOR like a normal statement id
	while (($row = oci_fetch_array($p_cursor, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
    	echo $row[0];
	}

    echo "0," . $str;
}

?>