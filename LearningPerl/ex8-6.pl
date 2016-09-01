#!/usr/bin/perl

use strict;
use warnings;

while (<>)
{
	chomp;
	if (/( +$)/)
	{
		print "$`\$\n";
	}
}
