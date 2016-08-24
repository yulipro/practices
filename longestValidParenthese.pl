#! perl
use strict;
use warnings;
use Data::Dumper;

my $len = $ARGV[0];
my $str='';
foreach (1 .. $len){
  my $i = int(rand(2));
  $str = $i == 1 ? $str.'(' : $str.')';
}
print Dumper $str, length($str);

sub longestvalidparenthese{
  my ($str)=@_;
  my @res;
  my $max =0;
  my ($s, $e)=(0,0);
  my $len = length($str);
  my $i=0;
  while($i < $len){
    my $cur = substr($str, $i, 1);
    print " looking at $i th, with char: $cur \n";
    if($cur eq '('){
      $res[$i]=0;
    }else{
      my $pre = $i>0 ? substr($str, $i-1, 1) : '';
      if( $i>0 && $pre eq '(' ){
        my $pre_2 = $i>=2 ? $res[$i-2] : 0;
        $res[$i] = $pre_2 + 2;
        print "case 1 \n";
        if( $res[$i] > $max){
          $max =  $res[$i] ;
          $e = $i;
          $s = $i-$max +1;
        }
      }else{
        my $inner_len =  $i>=1 ? $res[$i-1] : 0 ;
        my $idx_before_inner_len = $i - $inner_len - 1;
        if( $idx_before_inner_len >=0 && substr($str, $idx_before_inner_len , 1) eq '(') {
          my $len_prefix = $idx_before_inner_len>0 ?  $res[$idx_before_inner_len - 1 ] : 0 ;
          $res[$i] = $inner_len + 2 +  $len_prefix;
          if( $res[$i] > $max){
            $max =  $res[$i] ;
            $e = $i;
            $s = $i- $res[$i] + 1 ;
          }
        }else{
          $res[$i]=0;
        }
      }
    }
    $i++;
  }
  print "long est one starting AT: $s, endding at: $e of lenght: $max , substrin: ".substr($str, $s, $max)."\n";
  print Dumper @res;
}
#my $s='())((((())))())(()))';
longestvalidparenthese($str);

=comment
A cool Dynamic programming solution:

maintain an array of ints, index of which stores the length of valid parenthese upto/including index i.

if i-th char is '(', it cann't form a valid par, so dp[i] = 0;

if i-th char is ')', need to handle two sub problem
  if i-1 th is '(', then (i-1, i) form a valid pair, longest is current pair plus valid prefix before i-1, i.e. dp[i-2]+2.

  if i-1 th is ')', it means there is valid inner_sub of length dp[i-1], so we need to look at the char before the inner_len, if that one
  is '(', meaning there is a outter pair that covers inner_len sub pair, so dp[i] = inner_len +2 + the valid prefix before the this whole 
  pair.
  If there is no matching outer pair, no valid sub is formed, therefore, dp[i]=0.
=cut
