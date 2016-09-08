#!/usr/bin/perl

use 5.010;

use strict;
use warnings;

my $en_debug = 1;

my $debug = $en_debug // 0;

print "debug message.\n" if $debug;

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
