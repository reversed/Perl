#!/usr/bin/perl

use strict;
use warnings;

use Module::CoreList;

my %modules = %{ $Module::CoreList::version{5.006} };

print join "\n", keys %modules;
