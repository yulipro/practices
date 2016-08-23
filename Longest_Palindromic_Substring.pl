#! perl

use strict;
use warnings;
use Data::Dumper;
use List::Util qw( min max);
my $input = $ARGV[0];
my @res;
my $len = length($input);
my $max = 1;
foreach my $delta ( 0 .. $len -1){
  foreach my $i (  0 .. $len - 1 - $delta){
    my $j  = $i + $delta;
    print " looking at substring starting at: $i , ending at : $j \n";
    if($delta == 0){
      $res[$i][$j] = 1;
    }elsif( $delta ==1){
      $res[$i][$j] = substr( $input, $i ,1) eq substr( $input, $j ,1) ? 1 : 0 ;
      $max = max( $max , $j - $i +1 ) if $res[$i][$j];
    }else{
      $res[$i][$j] = substr( $input, $i ,1) eq substr( $input, $j ,1) && $res[$i+1][$j-1] ? 1 :0;
      $max = max( $max , $j - $i +1 ) if $res[$i][$j];
    }
  }
}
print Dumper $max;


=comment

This can be solved via Dynamic programming to identify any substr to be palindromic.

dp[i][j] is a boolean value to mark if substr str[i..j] is pal.

THis can be broken down to three cases,( possibly two ).

1. if i == j, meaning only one char in substr, is pal by definition.

2. if i == j-1, there are two chars in substr, dp[i][j] =1 iff str[i] eq str[j].

3.  if i < j-1 , dp[i][j] = 1 iff two chars are the same and substr str[i+1 .. j-1] is pal, aka, dp[i+1][j-1]=1.

=cut
