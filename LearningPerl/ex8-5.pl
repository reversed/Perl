#!/usr/bin/perl

use strict;
use warnings;

while (<>)
{
	chomp;
	if (/(\b\w*a\b)(.{0,5})/)
	{
		#print "Matched: |$`<$&>$'|\n";
		print "Matched: \$1 contains '$1', and next five char is '$2'\n";
	}
	else
	{
		print "No match: |$_|\n";
	}
}
