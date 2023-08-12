<?php
$this_dir = dirname(__FILE__);
$parent_dir = realpath($this_dir . '/../');
$target_path = $parent_dir . '/SavedAssets/';

error_reporting(0);
function gzfilesize($zp) {
      $gzfs = strlen($zp);
  return($gzfs);
}

$stringxd = $_GET['id'];
function uncompress($srcName, $dstName) {
    $sfp = gzopen($srcName, "rb");
    $fp = fopen($dstName, "w");

    while ($string = gzread($sfp, 4096)) {
        fwrite($fp, $string, strlen($string));
    }
    gzclose($sfp);
    fclose($fp);
}

if(file_exists("./".$_GET["id"]))
{
    header("Content-type: text/plain");
    die(file_get_contents("./".$_GET['id']));
}
else
{
if(file_exists($target_path.$_GET["id"]) && file_get_contents($target_path.$_GET['id'])!="")
{
 header("Content-type: text/plain");
	$finished = file_get_contents($target_path.$_GET['id']);
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
$file_name = $target_path.$_GET['id'];
$myfile = fopen($file_name, "w");
header($_SERVER["SERVER_PROTOCOL"] . " 200 OK");
    header("Cache-Control: public");
    header("Content-Type: application/zip");
    header("Content-Transfer-Encoding: Binary");
    header("Content-Length:".filesize($url));
    header("Content-Disposition: attachment; filename=filePath");
if (file_get_contents($urlxd)=="") {
$fp = fopen($file_name, "w");
$url = "https://api.hyra.io/audio/".$stringxd;
$finished = file_get_contents($urlxd);
fwrite($fp, $finished);
fclose($fp);
}
else
{
uncompress($urlxd,$file_name);
}
Header("Location: ".$urlxd);
}
else
{
$stringxd = $_GET['id'];
$url = "https://assetdelivery.roblox.com/v1/asset/?id=".$stringxd;
$file_name = $target_path.$_GET['id'];
$myfile = fopen($file_name, "w");
header($_SERVER["SERVER_PROTOCOL"] . " 200 OK");
    header("Cache-Control: public");
    header("Content-Type: application/zip");
    header("Content-Transfer-Encoding: Binary");
    header("Content-Length:".filesize($url));
    header("Content-Disposition: attachment; filename=filePath");
if (file_get_contents($url)=="") {
$fp = fopen($file_name, "w");
$url = "https://api.hyra.io/audio/".$stringxd;
$finished = file_get_contents($url);
fwrite($fp, $finished);
fclose($fp);
}
else
{
uncompress($url,$file_name);
}
Header("Location: ".$url);
}
}
}
}
?>