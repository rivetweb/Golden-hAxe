<?php

if(!function_exists("tmp_com_flippingbok_sortfiles")){
	function tmp_com_flippingbok_sortfiles($a, $b){
		preg_match("{([0-9]+)[.jpg|$.swf$]}i", $a, $ma);
		preg_match("{([0-9]+)[.jpg|$.swf$]}i", $b, $mb);
		return (int)$ma[1] > (int)$mb[1]? 1 :
			((int)$ma[1] < (int)$mb[1]? -1 : 0);
	}
}

$files = glob("../images/flippingbook/avon/Avon5/*");

print "Before\n";
print_r($files);

usort($files, "tmp_com_flippingbok_sortfiles");

print "After\n";
print_r($files);
