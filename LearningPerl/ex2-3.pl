#!/usr/bin/perl

use strict;
use warnings;

print "Radius: ";
chomp (my $radius = <STDIN>);

my $result;
if ($radius < 0)
{
	$result = 0;
}
else
{
	$result = 2*3.141592654*$radius;
}

print "$result\n";












