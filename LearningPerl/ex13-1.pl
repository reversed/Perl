#!/usr/bin/perl

use strict;
use warnings;

print "Please enter a directory name:\n";
chomp (my $dirname = <STDIN>);

if ($dirname =~ /^\s*$/)
{
    chdir "" or die "Can't open home dir\n";
}
else
{
    chdir $dirname or die "Can't open dir $dirname: $!\n";
}

my @files = glob "*";
foreach (@files)
{
    print "$_\n";
}
