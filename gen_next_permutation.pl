
#! perl
use strict;
use warnings;
use Data::Dumper;

sub rev{
  my ($a, $s, $e)=@_;
  while($s< $e){
    swap($a, $s, $e);
    $s++;
    $e--;
  }
}

sub swap{
  my ($a, $i, $j)=@_;
  my $temp = $a->[$i];
  $a->[$i]= $a->[$j];
  $a->[$j]=$temp;
}

sub nextperm{
  my ($a )=@_;
  my $size  =scalar( @$a);
  my $last  = $size -1;

  while( $last -1 >=0  && $a->[$last] <= $a->[$last-1] ){
    $last--;
  }

  if($last == 0){
    print "seq is end of perm: ".join(',', @$a)."\n";
    return 0;
  }
  my $pivot = $last;
  my $i = $size -1;
  while( $a->[$i] <= $a->[$pivot -1 ] ){
    $i--;
  }
  swap($a, $i, $pivot-1);
  rev($a,$pivot, $size-1);
  return 1;
}

#generate random int array composed of 0-9 of size K.
my $k = $ARGV[0];
my @a;
foreach ( 1 .. $k ){
  push @a , int( rand( 9 ) );
}


#iterate all next perms until the array is sorted in descending order.
while(nextperm(\@a)){
  print "cur per: ".join(',', @a)."\n";
}

