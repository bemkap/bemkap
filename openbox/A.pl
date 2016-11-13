#!/usr/bin/perl -W
use File::Basename;
use strict;
sub L {
    my ($p, $d) = @_;
    $p=~s/\&/\&amp;/g;
    $p=~s/\"/\&quot;/g;
    my $bn=basename($p);
    print "<menu id=\"$bn\" label=\"$bn\"><item label=\"open\"><action name=\"Execute\"><execute>thunar \"$p\"</execute></action></item><separator/>";
    if($d gt 2) { print "<item label=\"too deep\"/>"; } else {
	foreach my $f (glob("\"$p/*\"")) {
	    if(-d "$f") { L("$f", $d+1); }
	}
    }
    print "</menu>";
}
print "<openbox_pipe_menu>";
L("$ARGV[0]", 0);
print "</openbox_pipe_menu>";
