#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

sub greet
{
	state @names;

	my $cur = shift;

	print "Hi $cur! ";

	if (@names)
	{
		print "I've seen: @names\n";
	}
	else
	{
		print "You are the first one!\n"
	}
	push @names, $cur;
}

greet("Fred");
greet("Barney");
greet("Wilma");
greet("Betty");
