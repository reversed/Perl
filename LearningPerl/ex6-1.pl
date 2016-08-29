#!/usr/bin/perl

use strict;
use warnings;

my %hash =( 
             "fred" => "flintstone",
	     "barney" => "rubble",
             "wilma" => "flintstone"
          );

print "Please input a name: \n";

chomp (my $name = <STDIN>);

if (exists $hash{$name})
{
	print "$hash{$name}\n";
}
