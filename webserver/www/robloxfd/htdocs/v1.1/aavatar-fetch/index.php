<?php
$id = addslashes($_GET["userId"]);
$placeid = addslashes($_GET["placeId"]);
$url = "https://avatar.roblox.com/v1/avatar-fetch?placeId=$placeid&userId=$id";
echo file_get_contents($url)
?>