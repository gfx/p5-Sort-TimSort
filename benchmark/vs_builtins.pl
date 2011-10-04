#!perl -w
use strict;
use Benchmark qw(cmpthese);
use List::Util qw(shuffle);

use Sort::TimSort qw(timsort);

my @x = map { +{ value => $_ } } shuffle('aaa' .. 'zzz');

cmpthese -1, {
    mergesort => sub {
        use sort '_mergesort';
        my @z = sort { $a->{value} cmp $b->{value} } @x;
    },

    quicksort => sub {
        use sort '_quicksort';
        my @z = sort { $a->{value} cmp $b->{value} } @x;
    },

    timsort => sub {
        my @z = timsort { $_[0]->{value} cmp $_[1]->{value} } @x;
    },
};
