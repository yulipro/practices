
my $match={
           '('=>')',
           '['=>']',
           '{'=>'}',
          };
my $str = $ARGV[0];
my $len = length($str);
my @stack;
foreach my $i ( 0 .. $len -1){
  my $c =substr($str, $i, 1);
  if( $c eq '(' ||$c eq '{' ||$c eq '[' ){
    push @stack, $i;
  }else{
    if( scalar(@stack) == 0 || $match->{ substr( $str, $stack[-1] , 1) } ne $c ){
       print "false" ;
       exit;
     }
    pop @stack;
  }
}
if(scalar(@stack)){
  print "false";
}else{
  print "ture";
}


=comment
stack is key point.
=cut
