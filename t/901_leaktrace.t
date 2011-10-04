#!perl -w
use strict;
use Test::Requires { 'Test::LeakTrace' => 0.13 };
use Test::More;

use Sort::TimSort;

no_leaks_ok {
    # use Sort::TimSort here
};

done_testing;
