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

	/*
	Create or Replace Type job_Rec as object (
	itemId VARCHAR(10),
        contractId VARCHAR(10),
        custPhone VARCHAR(14),
        empNo VARCHAR(10),
        timeOfArrival DATE,
        status VARCHAR(12)
);*/

	while(($row=oci_fetch_array($query,OCI_BOTH)) != false) {
		$str = $row[0] . "|" . $row[1] . "|" . $row[2] . "|" . $row[3] . "|" . $row[4];
		array_push($data,$str)
	}

    echo "0," . implode(",",$data);
}

?>