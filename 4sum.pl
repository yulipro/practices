#! perl

use strict;
use warnings;
use Data::Dumper;

my @input = sort{ $a<=>$b } split(',', $ARGV[0]);
my $target = $ARGV[1];
my $size = scalar(@input);
foreach my $i1 ( 0 .. $size -4){
  foreach my $i2 ( $i1+1 .. $size -3){
    my $left = $i2+1;
    my $right = $size -1;
    while($left < $right ){
      if( $input[$i1] + $input[$i2] + $input[$left] + $input[$right] == $target){
        my @res = ($input[$i1] , $input[$i2] , $input[$left] , $input[$right]);
        print "Found a solution at ".join(',', @res)." \n";
        $left++;
      }elsif(  $input[$i1] + $input[$i2] + $input[$left] + $input[$right] < $target ){
        $left++;
      }elsif(  $input[$i1] + $input[$i2] + $input[$left] + $input[$right] > $target ){
        $right--;
      }
    }
  }
}

=comment
with frist two ptrs set,
move last two pointers towards each other.

This requires O(N*N*N) time complexity.
