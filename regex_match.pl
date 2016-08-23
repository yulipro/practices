#! perl

use strict;
use warnings;
use Data::Dumper;

my $str = $ARGV[0];
my $pat = $ARGV[1];
my @dp;
my $slen = length($str);
my $plen = length($pat);

foreach my $i ( 0 .. $slen ){
  foreach my $j ( 0 .. $plen ){
    if($i == 0 && $j ==0 ){
      $dp[0][0]=1;
    }elsif($i == 0 || $j ==0  ){
        $dp[$i][$j]=0;
    }else{
      my $sc = substr($str, $i-1 ,1);
      my $pc = substr($pat, $j-1 ,1);
      if ($pc eq '.') {
        $dp[$i][$j] = $dp[$i-1][$j-1];
      } elsif ($pc eq '*') {
        $dp[$i][$j] = $dp[$i-1][$j-1] || $dp[$i-1][$j] ;
      } else {
        $dp[$i][$j] = $dp[$i-1][$j-1] && $sc eq $pc ;
      }
      print "Looking at $i th in S of $sc and $j th in P of $pc, resultis:  ".$dp[$i][$j]."\n";
    }
  }
}

print Dumper @dp;
print "res is:". $dp[$slen][$plen];
