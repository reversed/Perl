#!/usr/bin/perl

use strict;
use warnings;

while (<>)
{
	chomp;
	if (/(\b\w*a\b)/)
	{
		#print "Matched: |$`<$&>$'|\n";
		print "Matched: \$1 contains '$1'\n";
	}
	else
	{
		print "No match: |$_|\n";
	}
}
