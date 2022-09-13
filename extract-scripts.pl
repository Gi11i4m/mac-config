#!/usr/bin/perl
use strict;
use warnings;

open(FILE, "README.md") || die("Could not open README");
my $text = do { local $/; <FILE> };

while( $text =~ /```bash(.*?)```/gms )
{
  print "$1";
}