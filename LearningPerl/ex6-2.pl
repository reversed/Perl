#!/usr/bin/perl

use strict;
use warnings;

print "Please input a name list: \n";

my %hash;
while (<STDIN>)
{
	chomp;
	$hash{$_} += 1;	
}

foreach (sort keys %hash)
{
	print "$_ => $hash{$_}\n";
}
