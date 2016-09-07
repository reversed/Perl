#!/usr/bin/perl

use strict;
use warnings;

$^I = ".bak";

while (<>)
{
    s/(^#!.*)/$1## Copyright xxxxxx\n/s;
    print;
}
