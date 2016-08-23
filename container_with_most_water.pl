#! perl

use strict;
use warnings;
use List::Util qw(min max);
use Data::Dumper;

my @height = split(',', $ARGV[0]);
my $left = 0;
my $right = scalar( @height) -1 ;
my $res = 0;
while($left < $right){
  my $min_h = min($height[$left], $height[$right]);
  if( $res <  $min_h  * ( $right - $left)){
    $res =max( $res ,  $min_h  * ( $right - $left) );
    print "FOund a new high at $left and $right of space $res\n";
  }
  if($height[$left] <= $min_h ){
    $left++;
  }elsif($height[$right] <= $min_h ){
    $right--;
  }
}


print Dumper $res;


=comment

this is a typical two-pointer problem, where left&right start from each end,

and move towards each other, starting with the smaller side.

=cut

