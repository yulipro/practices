
#! perl
use strict;
use warnings;
use Data::Dumper;

my $hash;
my $i =2;
my $start = 65;
while($i <=9){
  $hash->{$i}= [ chr($start++),chr($start++),chr($start++)];
  push @{ $hash->{$i} } , chr($start++) if $i ==9;
  $i++;
}
$hash->{1} = ['*'];
$hash->{0} = [' '];
print Dumper $hash;
#generating mappings from input digits to list of characters.



my $code = $ARGV[0];
my $len = length($code);
my @res=('');
foreach my $i ( 0 .. $len -1){
  my $c = substr($code, $i , 1);
  my $list = $hash->{$c};
  my $res_size = scalar(@res);
  while( $res_size >0 ){
    my $cur_str = shift( @res );
    foreach my $e ( @$list){
      push @res, $cur_str.$e;
    }
    $res_size--;
  }
}
print Dumper @res;
#iterative version of solution. Basic idea is using a queue starting from empty string,
#and go over each input char. Inside each loop, dequeue all the elements and enqueue back everyone 
#that appends different chars that map to current digit.


sub combination{
  my( $code,  $offset,  $cur,   $res, $hash)=@_;
  if( $offset >= length($code) ){
    push @$res, $cur;
    print "pushing $cur to result \n";
    return;
  }
  my $cur_char = substr($code, $offset, 1);
  foreach my $e ( @{ $hash->{$cur_char} }){
    my $new_c = $cur.$e;
    combination( $code, $offset+1, $new_c, $res, $hash);
  }
}
@res=();
combination( $code, 0, '', \@res, $hash);
print Dumper @res;

=comment
 This is recursive version. More of a DFS solution, again starting from emtpy string and 
 appending to current result with each mapped char for current code, until reaching the end of input. 
=cut

