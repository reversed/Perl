#!/usr/bin/perl

use strict;
use warnings;

my $file = $ARGV[0];

open LOG, "<$file";

while (<LOG>)
{
	chomp;
	if (/[A-Z]+[a-z]+/)
	{
		print "$_\n";
	}
}
