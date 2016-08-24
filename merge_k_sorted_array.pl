#! perl
use strict;
use warnings;
use Data::Dumper;
use Clone 'clone';

{
  package Heap;
  use Clone 'clone';

  sub new{
    my ( $class )=@_;
    my $self;
    $self->{container} = [];
    bless $self, $class;
    return $self;
  }

  sub heapify{
    my( $self , $idx )=@_;
    my $min = $idx;
    my $left = $idx*2+1;
    my $right = $left + 1;
    $min = $left  if( $left < $self->heap_size() && $self->{container}->[$idx]->{val} > $self->{container}->[$left]->{val} );
    $min = $right if( $right < $self->heap_size() && $self->{container}->[$right]->{val} < $self->{container}->[$min]->{val} );
    if($min != $idx){
      $self->swap( $idx, $min);
      $self->heapify( $min );
    }
  }

  sub swap{
    my( $self, $a, $b)=@_;
    my $temp = $self->{container}->[$a];
    $self->{container}->[$a]=$self->{container}->[$b];
    $self->{container}->[$b]= $temp;
  }

  sub heap_size{
    my ( $self)=@_;
    return scalar(@{$self->{container}});
  }
  sub heap_insert{
    my ($self, $obj)=@_;
    push @{$self->{container}} , $obj;
    my $cur = $self->heap_size() -1;
    while($cur){
      my $parent = int( ($cur-1) >> 1 );
      if($self->{container}->[$cur]->{val} < $self->{container}->[$parent]->{val} ){
        $self->swap( $cur, $parent);
        $cur= $parent;
      }else{
        return;
      }
    }
  }
  sub heap_pop{
    my ( $self )=@_;
    return if $self->heap_size() == 0;
    my $head = $self->{container}->[0];
    my $clone = clone($head);
    $self->swap( 0 , $self->heap_size() - 1 );
    delete $self->{container}->[-1] ;
    $self->heapify( 0 );
    return $clone;
  }
}

my $list=[];
my ($x, $y) = @ARGV;
foreach my $i (0 .. $x -1){
  my $array=[];
  foreach my $j (0 .. $y -1){
    push @$array, int( rand( 1000 ) );
  }
  my @sorted = sort{ $a<=>$b} @$array;
  push @$list, \@sorted;
}
print Dumper $list;

my @res;
my $heap = new Heap();
foreach my $e (  0 ..  scalar(@$list) -1 ){
  print "inserting val: ".$list->[$e][0] ." \n";
  $heap->heap_insert(  { val=>$list->[$e][0] , src=>$e , offset=>0 } );
}
while( $heap->heap_size() ){
  my $top = $heap->heap_pop();
  push @res , $top->{val};
  print Dumper $top;
  if($top->{offset} < scalar(  @{$list->[$top->{src}]}) -1 ){
    $heap->heap_insert( {val=>$list->[ $top->{src} ][ $top->{offset} +1 ] , src=>$top->{src} , offset=>$top->{offset}+1  }  );
  }else{
        print "Exhausting list $top->{src} \n";
  }
}

print Dumper @res;
