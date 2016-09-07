#!/usr/bin/perl

use strict;
use warnings;

my %do_these;
foreach (@ARGV)
{
    $do_these{$_} = 1;
}

while (<>)
{
    if (/^## Copyright/)
    {
        delete $do_these{$ARGV};
    }
}

@ARGV = sort keys %do_these;
$^I = ".bak";
while (<>)
{
    if (/^#!/)
    {
        $_ .= "## Copyright xxxxxx\n";
    }
    print;
}
