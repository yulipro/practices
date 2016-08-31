
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

my ($x, $y, $max )= @ARGV;
my @m;
foreach ( 1 .. $x ){
  my @x ;
  foreach ( 1 .. $y){
    push @x , int(rand($max));
  }
  push @m , \@x;
}
foreach my $i ( 0 .. $x -1 ){
  print join(" " , @{$m[$i]})."\n";
}
my $visited={};
sub dfs{
  my ( $x, $y , $matrix , $visited, $X, $Y )=@_;
  if( $x == $X -1 && $y == $Y -1){
    print Dumper $visited->{$x*$Y + $y};
    print "reaching the end at $x , $y : \n";
    my $cur = $x*$Y + $y;
    while($cur ){
      my $next = $visited->{$cur}->{from};
      my $f_x = int( $next/$Y );
      my $f_y = $next % $Y;
      print "going to $f_x , $f_y \n";
      $cur = $next;
    }
    return;
  }
  my $offsets= [
                [ -1,0],
                [0,1],
                [1,0],
                [0,-1],
               ];
  my @next ;
  foreach my $of ( @{$offsets}){
    my $nx = $x + $of->[0];
    my $ny = $y + $of->[1];
    next if  $nx < 0 || $nx >=$X || $ny < 0 || $ny >= $Y || defined $visited->{ $nx*$Y + $ny } ;
    push @next , { val=>$matrix->[$nx][$ny] ,  x=> $nx , y=>$ny  };
  }
  @next = sort{ $a->{val} <=> $b->{val}} @next;
  foreach my $e ( @next ){
    $visited->{ $e->{x}*$Y + $e->{y} }= {
                                        val => max( $visited->{ $x*$Y + $y}->{val} , $e->{val} ),
                                        from=> $x*$Y + $y
                                       };
    dfs( $e->{x}, $e->{y} , $matrix , $visited, $X, $Y );
  #  delete $visited->{$e->{x}*$Y + $e->{y} };
  }
}
$visited->{0}={
               val => $m[0][0],
               from => 0
};

dfs( 0, 0, \@m, $visited, $x, $y );
