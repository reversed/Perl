#!/usr/bin/perl

use strict;
use warnings;

foreach my $filename (@ARGV)
{
    print "Testing $filename:\n";

    unless (-e $filename)
    {
        print "$filename: non exist\n";
        next;
    }

    if (-r $filename)
    {
        print "$filename: readable\n";
    }
    else
    {
        print "$filename: non readable\n";
    }

    if (-w _)
    {     
        print "$filename: writable\n";
    }
    else
    {
        print "$filename: non writable\n"; 
    }

    if (-x _)
    {
        print "$filename: executable\n";
    }
    else
    {
        print "$filename: non executable\n";
    }
}
