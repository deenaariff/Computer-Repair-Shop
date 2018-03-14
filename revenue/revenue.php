<?php

/*
Given the machine id or customer-phone or email address, should show a machine(s) status. 
*/

if(!isset($_GET['date1']) || !isset($_GET['date2'] || !isset($_GET['case'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = $_GET['date1'];
$arg2 = $_GET['date2'];
$arg3 = $_GET['case'];

getRevenue($arg1, $arg2);

function getRevenue($date1, $date2, $warranty)
{
	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	//$queryString = 'begin\ :res := getRevenueGenerated(DATE :date1, DATE :date2);\ endl;';

	$date_string1 = "DATE '" . $date1 . "'";
	$date_string2 = "DATE '" . $date2 . "'";

	$function = "";

	switch ($case) {
	    case '1':
	        $function = "getRevenueGenerated";
	        break;
	    case '2':
	         $function = "getRevenueNoWarranty";
	        break;
	    case '3':
	        $function = "getRevenueWarranty";
	        break;
	    default:
	        $function = "getRevenueGenerated";
	}

	$queryString = "begin :res :=" . $function . "("; 
	$queryString = $queryString	. $date_string1 . ",";
	$queryString = $queryString . $date_string2 . "); end;";
	
	$query = oci_parse($conn,$queryString);

	oci_bind_by_name($query,':res', $str, 22, SQLT_CHR);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query " . $date1;
		exit();
	}

    echo "0," . $str;
}

?>