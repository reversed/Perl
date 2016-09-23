#/usr/bin/perl

use strict;
use warnings;

my $soft = 0;
if ($ARGV[0] eq "-s")
{
    shift @ARGV;
    $soft = 1;
}

my ($source, $dest) = @ARGV;

if ($soft == 0)
{
    link $source, $dest or die "Failed to link $source to $dest: $!\n";
}
else
{
 
    symlink $source, $dest or die "Failed to link $source to $dest: $!\n";
}
