#!/usr/bin/perl

use strict;
use warnings;

chdir "/" or die "Can't chdir to root directory: $!";
exec "ls", "-l" or die "Can't exec ls: $!";
