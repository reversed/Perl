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
    s/Fred/Larry/ig;
    print OUT $_;
}
