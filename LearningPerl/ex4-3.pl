#!/usr/bin/perl

use strict;
use warnings;

sub average
{
	if (@_ == 0) {return}

	my $num = @_;
	my $sum = 0;
	foreach (@_)
	{
		$sum += $_;
	}
	return $sum / $num;
}

sub above_average
{
	my $ave = average(@_);
	my @res;
	foreach (@_)
	{
		if ($_ > $ave)
		{
			push @res, $_;
		}		
	}
	return @res;
}

my @fred = above_average(1..10);
print "\@fred is @fred\n";

my @barney = above_average(100, 1..10);
print "\@barney is @barney\n";
