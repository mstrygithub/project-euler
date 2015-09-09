#!/usr/bin/perl

use strict;
use warnings;

use integer;
use bytes;

# use Math::BigInt lib => 'GMP', ':constant';

use List::Util qw(sum);
use List::MoreUtils qw();

STDOUT->autoflush(1);

my $sum = 0;

my $STEP = 1_000;
my $print_at = $STEP;
for my $n (2 .. 10_000_000)
{
    $sum += sub {
        for (my $x=$n-1;$x>1;$x--)
        {
            if ((($x*$x) % $n) == $x)
            {
                return $x;
            }
        }
        return 1;
    }->();
    if ($n == $print_at)
    {
        print "N=$n Sum = $sum\n";
        $print_at += $STEP;
    }
}

print "Final sum = $sum\n";
