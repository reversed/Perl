#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

while (<>)
{
	chomp;
	if (/(?<word>\b\w*a\b)/)
	{
		#print "Matched: |$`<$&>$'|\n";
		print "Matched: 'word' contains '$+{word}'\n";
	}
	else
	{
		print "No match: |$_|\n";
	}
}
