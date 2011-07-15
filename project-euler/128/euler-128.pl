#!/usr/bin/perl 

use strict;
use warnings;

sub is_prime
{
    my ($n) = @_;

    if ($n <= 1)
    {
        return 0;
    }

    my $top = int(sqrt($n));

    for my $i (2 .. $top)
    {
        if ($n % $i == 0)
        {
            return 0;
        }
    }

    return 1;
}

=head1 DESCRIPTION

A hexagonal tile with number 1 is surrounded by a ring of six hexagonal tiles, starting at "12 o'clock" and numbering the tiles 2 to 7 in an anti-clockwise direction.

New rings are added in the same fashion, with the next rings being numbered 8 to 19, 20 to 37, 38 to 61, and so on. The diagram below shows the first three rings.

By finding the difference between tile n and each its six neighbours we shall define PD(n) to be the number of those differences which are prime.

For example, working clockwise around tile 8 the differences are 12, 29, 11, 6, 1, and 13. So PD(8) = 3.

In the same way, the differences around tile 17 are 1, 17, 16, 1, 11, and 10, hence PD(17) = 2.

It can be shown that the maximum value of PD(n) is 3.

If all of the tiles for which PD(n) = 3 are listed in ascending order to form a sequence, the 10th tile would be 271.

Find the 2000th tile in this sequence.

=head1 Planning

0 ; 6 ; 12 ; 18 ;  - keeps increasing by +6.

So the formula is 1 + 

=cut

sub get_cell_n
{
    my ($y, $x) = @_;

    my $d = int(sqrt($y*$y+$x*$x));
    # $y is the 1,2,8,19 axis
    # $x is the 1,6,16,32... axis.
    
    if (($x > 0) && ($y > $x))
    {
        
    }
}

my $count = 1;

my $LAST_SIDE = 5;

my $ring_len = 6;
my $ring_start = 2;
my ($prev_ring_len, $prev_ring_start);
my $next_ring_len = 12;
my $next_ring_start = 8;

my $n = $ring_start;
for my $ring (1 .. 10_000)
{
    foreach my $side (0 .. $LAST_SIDE)
    {
        for my $cell (0 .. ($ring-1))
        {
            print "$n ; Neighbours = ", 

            my @vicinity;

            if ($cell != 0)
            {
                push @vicinity, $n-1;

                my $is_last = (($cell == $ring-1) && ($side == $LAST_SIDE));
                if ($is_last)
                {
                    push @vicinity, 6 * (($ring * ($ring + 1)) >> 1);
                }
                else
                {
                    push @vicinity, $n+1;
                }

                {
                    my $x = $prev_ring_start + $side * ($ring-1) + ($cell-1);
                    push @vicinity, $x;
                    if ($is_last)
                    {
                        push @vicinity, $prev_ring_start;
                    }
                    else
                    {
                        push @vicinity, $x+1;
                    }
                }

                {
                    my $x = $next_ring_start + $side * ($ring+1) + $cell;
                    # TODO : This is wrong for the cell == 0 ; side == 0
                    # item.
                    push @vicinity, $x, $x+1;
                }

                print join(",", sort { $a <=> $b } @vicinity);
            }
            print "\n";
            $n++;
        }
    }
}
continue
{
    if ($n != $next_ring_start)
    {
        die "Mismatched $n <=> $next_ring_start";
    }

    ( $prev_ring_len, $prev_ring_start, $ring_len, $ring_start ) =
    ($ring_len, $ring_start, $next_ring_len, $next_ring_start);
    
    $next_ring_start += $ring_len;
    $next_ring_len += 6;
}

