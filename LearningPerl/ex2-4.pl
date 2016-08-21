#!/usr/bin/perl

use strict;
use warnings;

print "First No: ";
chomp(my $n1 = <STDIN>);

print "Second No: ";
chomp(my $n2 = <STDIN>);


my $p = $n1 * $n2;
print "Product: $p\n";
