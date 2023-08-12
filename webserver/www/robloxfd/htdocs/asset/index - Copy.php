<?php
$this_dir = dirname(__FILE__);
$parent_dir = realpath($this_dir . '/../');
$target_path = $parent_dir . '/SavedAssets/';
if(file_exists("./".$_GET["id"]))
{
    header("Content-type: text/plain");
    die(file_get_contents("./".$_GET['id']));
}
else
{
if(file_exists($target_path.$_GET["id"]))
{
if (0 ==filesize($target_path.$_GET["id"]))
{
$stringxd = $_GET['id'];
$url = "https://api.hyra.io/audio/".$stringxd;
$url2 = "https://assetdelivery.roblox.com/v1/asset/?id=".$stringxd;
$file_name = $target_path.$_GET['id'];
$myfile = fopen($file_name, "w");
file_put_contents($file_name,file_get_contents($url));
Header("Location: ".$url2);
}
    header("Content-type: text/plain");
    die(file_get_contents($target_path.$_GET['id']));
}
else
{
if (strstr($_GET['id'],'http'))
{
$url2 = $_GET['id'];
Header("Location: ".$url2);
}
else
{
$stringxd = $_GET['id'];
if (strstr($stringxd,'1111111'))
{
$s2=explode("1111111", $stringxd)[1];
$urlxd = "https://assetdelivery.roblox.com/v1/asset/?id=".$s2."&version=1";
$file_name = $target_path.$_GET['id'];
$myfile = fopen($file_name, "w");
file_put_contents($file_name,file_get_contents($urlxd));
Header("Location: ".$urlxd);
}
else
{
$url = "https://assetdelivery.roblox.com/v1/asset/?id=".$stringxd;
$file_name = $target_path.$_GET['id'];
$myfile = fopen($file_name, "w");
file_put_contents($file_name,file_get_contents($url));
Header("Location: ".$url);
}
}
}
}
?>