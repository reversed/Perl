#!/usr/bin/perl

use strict;
use warnings;

my @names = qw (fred betty barney dino wilma pebbles bamm-bamm);

print "Please enter a number list: \n";
chomp (my @index = <STDIN>);

foreach my $i (@index)
{
	print "$names[$i - 1] ";
}
print "\n";


