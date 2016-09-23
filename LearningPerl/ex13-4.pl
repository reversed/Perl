#!/usr/bin/perl

use strict;
use warnings;

foreach (@ARGV)
{
    unlink $_ or warn "Can't remove file $_: $!\n";
}
