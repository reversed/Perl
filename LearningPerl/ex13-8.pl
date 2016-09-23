#!/usr/bin/perl

use strict;
use warnings;

my @files = glob "*";

foreach my $file (@files)
{
    if (my $val = readlink $file)
    {
        print "$file -> $val\n";
    }
}
