#!/usr/bin/perl

for(`bluetoothctl show`){if(/Powered: (yes|no)/){$power=$1;break}}
if($power eq "no"){print("Power off\n")}
else{
    @output=`bluetoothctl devices Connected`;
    if(0<scalar @output){$output[0]=~/Device ..:..:..:..:..:.. (.*)/ && print("$1\n")}
    else{print("No devices\n")}
}
