<?php
require("functions.php");
if(file_exists("./".$_GET["id"])) {
    header("Content-type: text/plain");
    die(sign(file_get_contents("./".$_GET['id'])));
}
Header("Location: https://assetdelivery.roblox.com/v1/asset/?id=".$_GET['id']);
?>