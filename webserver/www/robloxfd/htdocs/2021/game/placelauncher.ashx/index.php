<?php
error_reporting(~E_ALL);
header("content-type:text/plain");
$user = $_GET['user'];
$ip = $_GET['ip'];
$port = $_GET['port'];
$user = $_GET['user'];
$id = $_GET['id'];
$app = $_GET['app'];

$membership = file_get_contents("../../../settings/client/buildersClub.txt");

if ( $membership === "NBC" ) {
    $membership = "None";
}
elseif ( $membership === "BC" ) {
    $membership = "BuildersClub";
}
elseif ( $membership === "TBC" ) {
    $membership = "TurboBuildersClub";
}
elseif ( $membership === "OBC" ) {
    $membership = "OutrageousBuildersClub";
}
else {
    $membership = "None";
}

?>
{"jobId":"Test","status":2,"joinScriptUrl":"http://localhost/2021/game/join.ashx?placeid=1818&ip=<?php echo $ip ?>&port=<?php echo $port ?>&user=<?php echo $user ?>&id=<?php echo $id ?>&membership=<?php echo $membership ?>&app=<?php echo $app ?>","authenticationUrl":"http://localhost/2021/Login/Negotiate.ashx","authenticationTicket":"1","message":null}
