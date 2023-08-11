<?php
header("Content-type: text/plain");
if (file_exists('./ordereddatastore/'.$_GET['dsname']))
{
$fullstr = "[";

$dir = new DirectoryIterator(dirname("./ordereddatastore/".$_GET['dsname']."/*"));

foreach ($dir as $key => $fileinfo) {
    if (!$fileinfo->isDot()) {
        $filename_without_ext = $fileinfo->getFilename();
           $fullstr = $fullstr.file_get_contents("./ordereddatastore/".$_GET['dsname']."/".$filename_without_ext).",";  
    }
}

$new = substr($fullstr, 0, -1) . ']';
}
else
{
$new = "";
}
die($new);

?>