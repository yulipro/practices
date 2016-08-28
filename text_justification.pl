
#! perl
use strict;
use warnings;
use Data::Dumper;
use Clone 'clone';
use List::Util qw( min max);
use constant {
  MAX => 10000,
    MIN=> -10000,
  };

my @input = split(' ', $ARGV[0]);
my $L = $ARGV[1];
my $size = scalar(@input);
my @lens ;
my @extra_space;
foreach (@input){
  push @lens, length( $_);
}
foreach my $i ( 0 .. $size - 1){
  foreach my $j ( $i .. $size - 1){
    if($i == $j){
      $extra_space[$i][$j] = $L - $lens[$i];
    }else{
      $extra_space[$i][$j] =  $extra_space[$i][$j-1] -  1 - $lens[$j];
    }
    print "EXTra spaces needed between $i and $j is: ".$extra_space[$i][$j]."\n";
  }
}
my @cost;
foreach my $i ( 0 .. $size - 1){
  foreach my $j ( $i .. $size - 1){
    if( $size-1 != $j){
      $cost[$i][$j] =  $extra_space[$i][$j] >=0 ?  $extra_space[$i][$j] ** 3 :  MAX;
    }else{
      $cost[$i][$j] =  $extra_space[$i][$j] >=0 ? 0 : MAX;
    }
    print "cost between $i and $j is: ".$cost[$i][$j]."\n";
  }
}
print Dumper @cost;

my $set ={};
my @dp;
$dp[0] = $cost[0][0];
foreach my $i ( 1 .. $size - 1){
  my $cur = $cost[0][$i];
  my $split = 0;
  foreach my $j ( 0 .. $i - 1 ){
    my $here = $dp[$j] + $cost[$j+1][$i];
    if($here < $cur){
      $cur = $here;
      $split= $j;
    }
  }
  $dp[$i] = $cur;
  $set->{$i} = $split;
}

print Dumper @dp, $set;

my $end = $size -1;
while($end >0){
  my $start = $set->{$end} == 0 ? 0 : $set->{$end}+1;
  foreach my $i ( $start   .. $end){
    print $input[$i]." ";
  }
  print "\n";
  $end = $start ==0? 0 : $start-1;
}

