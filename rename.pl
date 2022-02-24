#!/usr/bin/perl
$s=0;
system("mkdir RENAME");
while(<>){
    if(!$s){
	if($_=~/(IMG-\d+-WA\d+\.jpg)/){
	    $s=1;
	    $n=$1;
	}
    }else{
	chomp;
	if($_=~/(IMG-\d+-WA\d+\.jpg)/){system("cp -f --backup=numbered $1 RENAME/'$m.jpg'");}
	else{
	    system("cp -f --backup=numbered $n RENAME/'$_.jpg'");
	    $m=$_;
	    $s=0;
	}
    }
}
