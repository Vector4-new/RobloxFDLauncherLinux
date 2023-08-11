<?php
if(file_exists("./items/".$_GET["key"])) {
    header("Content-type: text/plain");
    die(file_get_contents("./items/".$_GET['key']));
}
else
{
  header("Content-type: text/plain");
    die(file_get_contents("./test"));
}
?>