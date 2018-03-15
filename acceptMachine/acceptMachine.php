<?php

if(!isset($_GET['name']) || !isset($_GET['model']) || !isset($_GET['phone_number']) || !isset($_GET['c_id']) || !isset($_GET['m_id'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = $_GET['name'];
$arg2 = $_GET['model'];
$arg3 = $_GET['phone_number'];
$arg4 = $_GET['c_id'];
$arg5 = $_GET['m_id'];

acceptMachine($arg1, $arg2, $arg3, $arg4, $arg5);

function acceptMachine($name, $model, $number, $c_id, $m_id)
{

	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	$date = date("Y-m-d");
	$date_string = "DATE '" . $date . "'";

	
	/*(n_name,phone,n_item,model,cId, in_date, message)*/
	$queryString = "BEGIN acceptMachine(:name,:phone,:m_id,:model,:cid,:date,:msg); END;";

	$query = oci_parse($conn,$queryString);
	oci_bind_by_name($query,':name',$name);
	oci_bind_by_name($query,':phone',$number);
	oci_bind_by_name($query,':m_id',$m_id);
	oci_bind_by_name($query,':model',$model);
	oci_bind_by_name($query,':cid',$c_id);
	oci_bind_by_name($query,':date',$date_string);
	oci_bind_by_name($query,':msg',$message,60,SQLT_VCS);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query";
		exit();
	}

	//$str = implode (",", $arr);
    echo "0," . $message;
}

?>