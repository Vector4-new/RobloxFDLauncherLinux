<?php
require("functions.php");
header("content-type:text/plain");
$port = $_GET['port'];
$f1 = str_replace("%port%",$port,file_get_contents("./2014host.txt"));
echo(sign($f1));
?>
