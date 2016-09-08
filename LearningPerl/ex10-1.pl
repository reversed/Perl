#!/usr/bin/perl

use strict;
use warnings;

my $ans = int(1 + rand 100);

while(1)
{
    print "Guess the number: ";

    chomp(my $in = <STDIN>);
    if ($in =~ /quit|exit|^\s*$/i)
    {
        print "User quits.\n";
        last;
    }   
    elsif ($in == $ans)
    {
        print "Correct! The answer is $ans.\n";
        last; 
    }
    elsif ($in > $ans)
    {
        print "Too high.\n";
    }
    elsif ($in < $ans)
    {
        print "Too low.\n";
    }
}
