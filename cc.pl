use Binance::API;
use List::Util qw(min max);
use strict;
my $api=Binance::API->new(
    apiKey   =>'kCAGR21EIxWDvMbm4ipT1mSlplJTF8aHWdsiqcoZ5U2yeYwwtNz81ER7HZB3zUn1',
    secretKey=>'dvZUtcQahlyY2VU93xJapd0LZF4Qfv41T1kfyTwZpkogXKoyPQMf2zbFhbwzeAsj',
    );
my $gs=8;
my $im=100;
my $st=0;

sub disc{
    my($lo,$hi,$in,$n)=@_;
    print "$lo $hi $in $n\n";
    return int(($n-$lo)/(($hi-$lo)/$in));
}
# while(){
my $xrp_hist=$api->klines(symbol=>'XRPUSDT',interval=>'30m',limit=>'167');
my @g=();
my @v=();
foreach(@{$xrp_hist}){push(@v,@{$_}[1,2,3,4])}    
for(my $i=min(@v);$i<max(@v);$i+=(max(@v)-min(@v))/$gs){push(@g,$i)}
    # foreach(1..48){
my $xrp=$api->ticker_price(symbol=>'XRPUSDT');
print disc(min(@v),max(@v),$gs,$xrp->{'price'})."\n";
# }
