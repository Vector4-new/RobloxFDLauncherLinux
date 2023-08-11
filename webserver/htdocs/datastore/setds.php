<?php

$file_name = $_GET['key'];
$myfile = fopen("./items/".$file_name, "w");
file_put_contents("./items/".$file_name,$_GET['data']);
header("Content-type: text/plain");
die(file_get_contents("./items/".$_GET['key']));

?>