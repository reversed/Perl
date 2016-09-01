#!/usr/bin/perl

use strict;
use warnings;

while (<>)
{
	chomp;
	if (/match/)
	{
		print "Matched: |$`<$&>$'|\n";
	}
	else
	{
		print "No match: |$_|\n";
	}
}
