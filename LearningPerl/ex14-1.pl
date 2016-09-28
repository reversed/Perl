#!/usr/bin/perl

use strict;
use warnings;

my @in;

while (<>)
{
    push @in, split;
}

my @numbers = sort { $a <=> $b } @in;

foreach (@numbers)
{
    printf "%20g\n", $_;
}

