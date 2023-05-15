#!/usr/bin/perl
use Binance::API;
use List::Util qw(min max);
use strict;
my $api=Binance::API->new(
    apiKey   =>'kCAGR21EIxWDvMbm4ipT1mSlplJTF8aHWdsiqcoZ5U2yeYwwtNz81ER7HZB3zUn1',
    secretKey=>'dvZUtcQahlyY2VU93xJapd0LZF4Qfv41T1kfyTwZpkogXKoyPQMf2zbFhbwzeAsj',
    );

my $btc=0.00346117;
my $eth=0;
my $btcp=$api->ticker_price(symbol=>'BTCUSDT')->{'price'};
my $ethp=$api->ticker_price(symbol=>'ETHUSDT')->{'price'};
printf("<fc=yellow>BTC</fc> %8.2f (%.2f) <fc=yellow>ETH</fc> %7.2f (%.2f)\n",$btcp,$btc*$btcp,$ethp,$eth*$ethp);
