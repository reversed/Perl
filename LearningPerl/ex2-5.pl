#!/usr/bin/perl

use strict;
use warnings;

print "String: ";
my $str = <STDIN>;

print "Number: ";
chomp(my $no = <STDIN>);

my $res = $str x $no;

print $res;
