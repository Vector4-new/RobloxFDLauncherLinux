<?php
$this_dir = dirname(__FILE__);
$parent_dir = realpath($this_dir . '/../../');
$target_path = $parent_dir . '/SavedAssets/';

error_reporting(0);
function gzfilesize($zp) {
      $gzfs = strlen($zp);
  return($gzfs);
}


if(file_exists("./".$_GET["id"]))
{
    header("Content-type: text/plain");
    die(file_get_contents("./".$_GET['id']));
}
else
{
if(file_exists($target_path.$_GET["id"]))
{
    header("Content-type: text/plain");
	$finished = file_get_contents($target_path.$_GET['id']);
if(@fread($finished, 2) == "\x1F\x8B") {
	$finished = gzread($finished, gzfilesize($finished));
}
if (!gzeof(gzopen($target_path.$_GET['id'],"rb"))) {
	if (gzopen($target_path.$_GET['id'],"rb")>0) {
	$finished = gzread(gzopen($target_path.$_GET['id'],"rb"), gzfilesize($finished));
	}
};
    echo $finished;
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
Header("Location: ".$urlxd);
$file_name = $target_path.$_GET['id'];
$finished = file_get_contents($urlxd);
if ( '' == $finished )
{
Header("Location: ".$urlxd);
}
else
{
if(@fread($finished, 2) == "\x1F\x8B") {
	$finished = gzread($finished, gzfilesize($finished));
}
if (!gzeof(gzopen($target_path.$_GET['id'],"rb"))) {
	if (gzopen($target_path.$_GET['id'],"rb")>0) {
	$finished = gzread(gzopen($target_path.$_GET['id'],"rb"), gzfilesize($finished));
	}
};
$myfile = fopen($file_name, "w");
fwrite($myfile,$finished);
}
}
else
{
$stringxd = $_GET['id'];
$url = "https://assetdelivery.roblox.com/v1/asset/?id=".$stringxd;
Header("Location: ".$url);
$finished = file_get_contents($url);
$file_name = $target_path.$_GET['id'];
if ( '' == $finished )
{
Header("Location: ".$url);
}
else
{
if(@fread($finished, 2) == "\x1F\x8B") {
	$finished = gzread($finished, gzfilesize($finished));
}
if (!gzeof(gzopen($target_path.$_GET['id'],"rb"))) {
	if (gzopen($target_path.$_GET['id'],"rb")>0) {
	$finished = gzread(gzopen($target_path.$_GET['id'],"rb"), gzfilesize($finished));
	}
};
$myfile = fopen($file_name, "w");
fwrite($myfile,$finished);
}
}
}
}
}
?>