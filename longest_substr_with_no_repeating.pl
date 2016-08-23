#! perl

use strict;
use warnings;
use Data::Dumper;
use List::Util qw( min max);


my $str = $ARGV[0];
my %hash;
my $len = length($str);
my ($left, $right)=(0,0);
my $res =0;
while($right< $len){
  my $c = substr($str, $right, 1);
  my $offset = defined $hash{$c} ?$hash{$c} : -1;
  $left = max( $left, $offset  );
  if($res < $right - $left){
    print "unq substr: ". substr($str, $left, $right - $left)." from: $left to: ".$right." \n";
  }
  $res =  $res < $right - $left ? $right - $left  :  $res;
  $hash{$c}= $right;
  $right++;
}
print Dumper $res;


=comment
some say this solution falls in Dynamic programming paradigm, which I tend to agree.
With solution of substr[0..i-1] at hand, we look at the subproblem with (i)th char.
There are two cases,
1. if ith char has never been seen before, we can extend longest substr by one;
2, otherwise, longest substr could possibly start from previous char, till but not including current ith char.
=cut




