#!/usr/bin/perl

use strict;
use warnings;

print "Please print a list of string:\n";

chomp (my @strs = <STDIN>);

print "Please enter the width:\n";
chomp (my $width = <STDIN>);

my $ruler = ($width / 10) + 1;

print "1234567890" x $ruler, "\n";
for my $str (@strs)
{
	printf "%${width}s\n", $str;
}

