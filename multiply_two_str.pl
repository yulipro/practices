#! perl
use strict;
use warnings;
use Data::Dumper;

my ($os1, $os2) = @ARGV;
my $s1 = reverse($os1);
my $s2 = reverse($os2);
my $l1 = length( $s1);
my $l2 = length( $s2);
my @res = (0) x ($l1 + $l2);

foreach my $i ( 0 .. $l1 - 1  ){
  foreach my $j ( 0 .. $l2 - 1 ){
    my $sum = int( substr($s1, $i ,1 ) )*int( substr($s2, $j ,1 ));
    my $cur_pos = $i+ $j ;
    my $carry_pos = $i + $j + 1;
    $sum+=$res[$cur_pos];

    $res[$cur_pos] =  $sum%10;
    $res[$carry_pos]+= int( $sum/10 );
    print "current array looks likt: ".join('', @res )."\n";
  }
}
my $str = join('', @res );
print Dumper $str;

if(index($str , '0' ) == 0 ){
  print "Rest is 0 \n";
}else{
  my $r = substr( $str, 0, index($str , '0' ) );
  print "res is ".reverse($r)."\n";

}

