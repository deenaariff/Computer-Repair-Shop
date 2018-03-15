<?php

if(!isset($_GET['name']) || !isset($_GET['model']) || !isset($_GET['phone_number'])  || !isset($_GET['c_id'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = $_GET['name'];
$arg2 = $_GET['model'];
$arg3 = $_GET['phone_number'];
$arg4 = $_GET['c_id'];

acceptMachine($arg1, $arg2, $arg3, $arg4);

function acceptMachine($name, $model, $number, $c_id)
{

	$conn=oci_connect('mcai','magstar816','dbserver.engr.scu.edu/db11g');
	if(!$conn) {
		echo "1, Error Connecting To Database";
		exit();
	}

	$date = date("Y-m-d");
	$date_string = "DATE '" . $date . "'";

	/*acceptMachine(n_name,n_item,model,cId,in_date,message OUT VARCHAR2)*/
	$queryString = "BEGIN acceptMachine(:name,:phone,:model,:cid," . $date_string . ",:msg); END;";

	$query = oci_parse($conn,$queryString);
	oci_bind_by_name($query,':name',$name);
	oci_bind_by_name($query,':phone',$number);
	oci_bind_by_name($query,':model',$model);
	oci_bind_by_name($query,':cid',$c_id);
	oci_bind_by_name($query,':msg',$message);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query";
		exit();
	}

	//$str = implode (",", $arr);
    echo "0," . $message;
}

?>