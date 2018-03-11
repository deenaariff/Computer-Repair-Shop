<?php

if(!isset($_GET['name']) || !isset($_GET['model']) || !isset($_GET['service_contract'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = $_GET['name'];
$arg2 = $_GET['model'];
$arg3 = $_GET['service_contract'];

acceptMachine($arg1, $arg2, $arg3);

function acceptMachine($name, $model, $s_contract)
{
	$arr = array ( 0 => $name, 1 => $model, 2 => $s_contract);
	$str = implode (",", $arr);
    echo "0," . $str;
}

?>