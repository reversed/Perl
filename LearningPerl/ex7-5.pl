#!/usr/bin/perl

use strict;
use warnings;

my $file = $ARGV[0];

open LOG, "<$file";

while (<LOG>)
{
	chomp;
	if (/(\S)\1/)
	{
		print "$_\n";
	}
}
