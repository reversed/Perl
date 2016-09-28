#!/usr/bin/perl

use strict;
use warnings;

my %last_name = qw{
    fred flintstone Wilma Flintstone Barney Rubble
    betty rubble Bamm-Bamm Rubble PEBBLES FLINTSTONE
};

sub compare_fun
{
    "\L$last_name{$b}" cmp "\L$last_name{$a}"
    or
    "\L$b" cmp "\L$a"
}

my @names = sort compare_fun keys %last_name;

foreach (@names)
{
    print "$last_name{$_},  $_\n";
}
