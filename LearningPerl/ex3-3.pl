#!/usr/bin/perl

print "Please enter a name list: \n";
chomp (my @names = <STDIN>);

@names = sort @names;

print "$_ " for (@names);
print "\n";

