#!/usr/bin/perl

use strict;
use warnings;

my $what = 'fred|barney';

while (<>)
{
    if (/($what)($what)($what)/)
    {
        print;
    }
}
