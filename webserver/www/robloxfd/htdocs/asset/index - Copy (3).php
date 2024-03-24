<?php
$this_dir = dirname(__FILE__);
$parent_dir = realpath($this_dir . '/../');
$target_path = $parent_dir . '/SavedAssets/';

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
$handle = gzopen( $target_path.$_GET['id'], 'r');   
if ( !gzeof($handle) )
{
	$finished = "";
}	
while ( !gzeof($handle) )
{
    $buffer = gzgets( $handle, 2048 );
        $finished = $finished . $buffer . "\n";
}
gzclose($handle);
	ob_flush();
flush();
    die($finished);
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
$finished = file_get_contents($urlxd);
if ( '' == $finished )
{
Header("Location: ".$urlxd);
}
else
{
header("Content-type: text/plain");
ob_flush();
flush();
$handle = gzopen( $urlxd, 'r');   
if ( !gzeof($handle) )
{
	$finished = "";
}	
while ( !gzeof($handle) )
{
    $buffer = gzgets( $handle, 2048 );
        $finished = $finished . $buffer;
}
gzclose($handle);
if(@fread($finished, 2) == "\x1F\x8B") {
	//$finished = gzread($finished, gzfilesize($finished));
}
    echo $finished;
$myfile = fopen($file_name, "w");
fwrite($myfile,$finished);
}
}
else
{
$stringxd = $_GET['id'];
$url = "https://assetdelivery.roblox.com/v1/asset/?id=".$stringxd;
$finished = file_get_contents($url);
$file_name = $target_path.$_GET['id'];
if ( '' == $finished )
{
Header("Location: ".$url);
}
else
{
header("Content-type: text/plain");
ob_flush();
flush();
$handle = gzopen( $url, 'r');   
if ( !gzeof($handle) )
{
	$finished = "";
}	
while ( !gzeof($handle) )
{
    $buffer = gzgets( $handle, 2048 );
        $finished = $finished . $buffer;
}
gzclose($handle);
if(@fread($finished, 2) == "\x1F\x8B") {
	$finished = gzread($finished, gzfilesize($finished));
}
echo $finished;
$myfile = fopen($file_name, "w");
fwrite($myfile,$finished);
}
}
}
}
}
?>
