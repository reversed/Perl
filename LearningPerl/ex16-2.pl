#!/usr/bin/perl

use strict;
use warnings;

open STDOUT, ">ls.out" or die "Can't write to ls.out:$!";
open STDERR, ">ls.err" or die "Can't write to ls.err:$!";
chdir "/" or die "Can't chdir to root directory: $!";
exec "ls", "-l" or die "Can't exec ls: $!";
