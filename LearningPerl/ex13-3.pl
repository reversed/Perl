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

my @files;
opendir DH, "." or die "Can't open current dir: $!\n";
while (my $name = readdir DH)
{
    push @files, $name;
}

foreach (sort @files)
{
    print "$_\n";
}

# foreach (sort readdir DH)
