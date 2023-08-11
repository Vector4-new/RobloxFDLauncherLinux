<?php

if (!file_exists('./ordereddatastore/'.$_GET['dsname'])) {     mkdir('./ordereddatastore/'.$_GET['dsname'], 0777, true); }
$file_name = $_GET['key'];
$myfile = fopen("./ordereddatastore/".$_GET['dsname']."/".$file_name, "w");
file_put_contents("./ordereddatastore/".$_GET['dsname']."/".$file_name,$_GET['data']);
header("Content-type: text/plain");

$fullstr = "[";

$dir = new DirectoryIterator(dirname("./ordereddatastore/".$_GET['dsname']."/*"));

foreach ($dir as $key => $fileinfo) {
    if (!$fileinfo->isDot()) {
        $filename_without_ext = $fileinfo->getFilename();
           $fullstr = $fullstr.file_get_contents("./ordereddatastore/".$_GET['dsname']."/".$filename_without_ext).", ";  
    }
}

$new = substr($fullstr, 0, -1) . ']';

die($new);

?>