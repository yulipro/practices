
#! perl
use strict;
use warnings;
use Data::Dumper;

my $len = $ARGV[0];
my @res;

sub genParenthese{
  my( $cur, $left, $right, $len, $res)=@_;
  print "INPUTS are cur : $cur , left : $left , right: $right \n";
  return if($left < $right );
  if($left == $len && $left == $right ){
    print "\tfound one: $cur \n";
    push @$res, $cur;
    return;
  }
  return if $left > $len || $right > $len ;
  if($left  ==  $right ){
    genParenthese( $cur.'(', $left+1, $right, $len, $res );
  }elsif($left > $right){
    genParenthese( $cur.'(', $left+1,  $right, $len, $res );
    genParenthese( $cur.')', $left,    $right + 1, $len, $res );
  }
}
genParenthese('',0,0, $len, \@res);
print Dumper @res;

=comment
this is dfs solution, where you start from the root of solution tree and go to the leaf, 
until there is either a valid solution or invalid one.
=cut

@res=();

sub deepcopy{
  my ($copy, $o)=@_;
  foreach my $key ( keys %$o){
    $copy->{$key} = $o->{$key};
  }
}
my @queue ;
push @queue, {l=>0,r=>0,s=>''};
while( scalar(@queue ) ){
  print Dumper @queue;
  my $size = scalar(@queue ) ;
  while($size ){
    my $next = pop( @queue );
    my $left = $next->{l};
    my $right = $next->{r};
    if(  $left > $len ||  $right > $len || $right> $left){
      $size--;
      next;
    };

    if( $left == $right && $left == $len){
      print "ofudn one: ".$next->{s}."\n";
      push @res, $next->{s};
    }elsif( $left >= $right  ){
      my %cp;
      deepcopy(\%cp, $next);
      $next->{l}++;
      $next->{s}.='(';
      unshift(@queue, $next);
      $cp{r}++;
      $cp{s}.=')';
      unshift(@queue, \%cp) if  $left > $right ;
    }
    $size--;
  }
}
print Dumper @res;

=comment
bfs version or layer by layer traversal to visit all possible solutions.
=cut
