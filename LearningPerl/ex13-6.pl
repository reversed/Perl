#!/usr/bin/perl

use strict;
use warnings;

my ($source, $dest) = @ARGV;

link $source, $dest or die "Failed to link $source to $dest: $!\n";

