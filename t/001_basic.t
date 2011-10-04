#!perl -w
use strict;
use Test::More;

use Sort::TimSort qw(timsort);
use List::Util    qw(shuffle);

srand(0);

my @x = shuffle('a' .. 'd');
my @t = @x;

is_deeply [ timsort { $_[0] cmp $_[1] } @x ], ['a' .. 'd'];
is_deeply \@x, \@t;

is_deeply [ timsort { $_[1] cmp $_[0] } @x ], [reverse 'a' .. 'd'];
is_deeply \@x, \@t;

for (1 .. 10) {
    @x = shuffle('aa' .. 'dd');
    is_deeply [ timsort { $_[0] cmp $_[1] } @x ], ['aa' .. 'dd'];
}

done_testing;
