<?php
require("functions.php");
header("content-type:text/plain");
$port = $_GET['port'];
$user = $_GET['username'];
$ip = $_GET['ip'];
$id = $_GET['id'];
$app = $_GET['app'];
$mode = $_GET['mode'];

$membershipType = file_get_contents("../../settings/client/buildersClub.txt");

if ( $membershipType === "NBC" ) {
    $membershipType = "None";
}
elseif ( $membershipType === "BC" ) {
    $membershipType = "BuildersClub";
}
elseif ( $membershipType === "TBC" ) {
    $membershipType = "TurboBuildersClub";
}
elseif ( $membershipType === "OBC" ) {
    $membershipType = "OutrageousBuildersClub";
}
else {
    $membershipType = "None";
}

$f1 = str_replace("%user%",$user,file_get_contents("./2014join.txt"));
$f2 = str_replace("%ip%",$ip,$f1);
$f3 = str_replace("%port%",$port,$f2);
$f4 = str_replace("%id%",$id,$f3);
$f5 = str_replace("%app%",$app,$f4);
$f6 = str_replace("%mode%",$mode,$f5);
$f7 = str_replace("%BCTYPE%", $membershipType, $f6);

echo(sign($f7));
?>
