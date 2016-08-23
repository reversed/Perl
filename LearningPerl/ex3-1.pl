#!/usr/bin/perl

chomp(my @strs = <STDIN>);

foreach (reverse @strs)
{
	print "$_\n";
}




