#!/usr/bin/perl

use strict;
use warnings;

while (<>)
{
	chomp;
	if (/a\b/)
	{
		print "Matched: |$`<$&>$'|\n";
	}
	else
	{
		print "No match: |$_|\n";
	}
}
