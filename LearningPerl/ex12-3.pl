#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

foreach (@ARGV)
{
    if (-e -r -w -o $_)
    {
        print "$_\n";
    }
}
