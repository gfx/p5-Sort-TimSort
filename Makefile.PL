#!perl
use strict;
use warnings;
BEGIN {
    unshift @INC, 'inc';

    # author requires, or bundled modules
    my @devmods = qw(
        inc::Module::Install             1.00
        Module::Install::AuthorTests     0.002
        Module::Install::Repository      0.06
        Test::Requires                   0.06
        Module::Install::XSUtil 0.41
    );
    my @not_available;
    while(my($mod, $ver) = splice @devmods, 0, 2) {
        eval qq{use $mod $ver (); 1} or push @not_available, $mod;
    }
    if(@not_available) {
        print qq{# The following modules are not available.\n};
        print qq{# `perl $0 | cpanm` will install them:\n};
        print $_, "\n" for @not_available;
        exit 1;
     }
}
use inc::Module::Install;
makemaker_args CC => 'g++';
makemaker_args LD => 'g++';

all_from 'lib/Sort/TimSort.pm';

use_xshelper;
requires_cplusplus;
cc_warnings;
cc_src_paths 'src';

test_requires 'Test::More'     => '0.88';
test_requires 'Test::Requires' => '0.06';

auto_set_repository;

tests_recursive;
author_tests 'xt';


clean_files qw(
    Sort-TimSort-*
    *.stackdump
    cover_db *.gcov *.gcda *.gcno
    nytprof
    *.out
);

WriteAll(check_nmake => 0);

