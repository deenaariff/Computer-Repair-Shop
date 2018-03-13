<?php

if(!isset($_GET['name']) || !isset($_GET['model']) || !isset($_GET['service_contract'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = $_GET['name'];
$arg2 = $_GET['model'];
$arg3 = $_GET['phone_number']

acceptMachine($arg1, $arg2, $arg3);

function acceptMachine($name, $model, $number)
{

	/*acceptMachine(n_name in VARCHAR, model in VARCHAR, cId in VARCHAR, in_date in DATE)*/
	$queryString = "exec acceptMachine(:name,:model,:cid,:date)";

	$date = "2015-12-11"

	$query = oci_parse($conn,$queryString);
	oci_bind_by_name($query,':name',$nams);
	oci_bind_by_name($query,':model',$model);
	oci_bind_by_name($query,':cid',$number);
	oci_bind_by_name($query,':date',$date);

	$res = oci_execute($query);

	if(!$res) {
		echo "1, Error in Database Query";
		exit();
	}

	$arr = array ( 0 => $name, 1 => $model, 2 => $s_contract);

	$str = implode (",", $arr);
    echo "0," . $str;
}

?>