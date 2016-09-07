#!/usr/bin/perl

use strict;
use warnings;

my $filename = $ARGV[0];
my $outname = $filename;
$outname =~ s/$/.out/;

open IN, "<$filename";
open OUT, ">$outname";

while (<IN>)
{
    chomp;
    s/Fred/\n/ig;
    s/Wilma/Fred/ig;
    s/\n/Wilma/ig;
    print OUT "$_\n";
}
