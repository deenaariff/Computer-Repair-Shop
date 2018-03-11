<?php

if(!isset($argv[1]) && !isset($_GET['number'])) {
	echo "1, Some Input Field Are Empty";
	exit();
}

$arg1 = '';

if(isset($argv[1])) $arg1 = $argv[1];
if(isset($_GET['number'])) $arg1 = $_GET['number'];

getCustInfo($arg1);

function getCustInfo($number)
{
	$arr = array ( 0 => "Deen Aariff", 1 => "408-249-5666", 2 => "S00023", 3 => "Samsung", 4 => date("Y/m/d"));
	

	$str = implode (",", $arr);
    echo "0," . $str;
}

?>