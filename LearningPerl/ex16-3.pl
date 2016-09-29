#!/usr/bin/perl

use strict;
use warnings;

if (`date` =~ /^S/)
{
    print "go play!\n";
}
else
{
    print "get to work!\n";
}
