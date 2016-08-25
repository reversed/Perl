#!/usr/bin/perl

use strict;
use warnings;

print "Please print a list of string:\n";

chomp (my @strs = <STDIN>);

print "123456789012345678901234567890\n";
for my $str (@strs)
{
	printf "%20s\n", $str;
}

