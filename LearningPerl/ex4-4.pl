#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

sub greet
{
	state $last;

	unless ($last)
	{
		print "Hi $_[0]! You are the first one here!\n";
	}
	else
	{
		print "Hi $_[0]! $last is also here!\n";
	}
	$last = $_[0];
}

greet("Fred");
greet("Barney");
