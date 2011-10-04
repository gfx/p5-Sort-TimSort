#!perl -w
use strict;
use Test::More tests => 1;

BEGIN {
    use_ok 'Sort::TimSort';
}

diag "Testing Sort::TimSort/$Sort::TimSort::VERSION";
