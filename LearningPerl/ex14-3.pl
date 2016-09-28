#!/usr/bin/perl

use strict;
use warnings;

my $example = "This is a test.";

my $test = "is";

my @places;

for (my $pos = -1; ; )
{
    $pos = index($example, $test, $pos + 1);
    last if $pos == -1;
    push @places, $pos;
}

print "@places\n";
