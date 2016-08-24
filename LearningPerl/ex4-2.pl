#!/usr/bin/perl -w

use strict;
use warnings;

sub total
{
	my $sum = 0;
	$sum += $_ foreach (@_);
	return $sum;
}

my @fred = qw { 1 3 5 7 9 };
my $fred_total = total(@fred);

print "The total: $fred_total.\n";

my $thou = total(1..1000);
print "The total: $thou.\n";

print "Enter some numbers on seperate lines: ";
my $user_total = total(<STDIN>);
print "The total: $user_total.\n";
