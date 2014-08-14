#!perl -T
use 5.010000;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Music::PitchNum' ) || print "Bail out!\n";
}

diag( "Testing Music::PitchNum $Music::PitchNum::VERSION, Perl $], $^X" );
