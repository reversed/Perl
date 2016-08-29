#!/usr/bin/perl

use strict;
use warnings;

print "ENV HASH:\n";

foreach my $res (sort keys %ENV)
{
	print "$res => $ENV{$res}\n";
}
