#!/usr/bin/perl

use strict;
use warnings;

my $filename = "test.txt";
open FILE, $filename or die "Can't open '$filename':$!";
chomp(my @strings = <FILE>);

while (1)
{
    print "Please enter a pattern: ";
    chomp(my $pattern = <STDIN>);
    last if $pattern =~ /^\s*$/;

    my @matches = eval
    {
        grep /$pattern/, @strings;
    };
    if ($@)
    {
        print "Error: $@";
    }
    else
    {
        my $count = @matches;
        print "There were $count matching strings:\n", map "$_\n", @matches;   
    }
    print "\n";
}
