<?php
$item1 ="126314837";
$item2 ="126314820";
$item3 ="119916949";
$item4 = "71037101";
$item5= "159229806";
$v1 = addslashes($_GET["v1"]);
if($v1 == "true"){$characterstring = "http://sitetest4.robloxlabs.com/game/bodycolors.xml;http://www.rbolock.cf/asset/?id=$item1;http://www.rbolock.cf/asset/?id=$item2;http://www.rbolock.cf/asset/?id=$item3;http://www.rbolock.cf/asset/?id=$item4;http://www.rbolock.cf/asset/?id=$item5;";} 
else {$characterstring = "A fatal error has occured";}
echo $characterstring
?>