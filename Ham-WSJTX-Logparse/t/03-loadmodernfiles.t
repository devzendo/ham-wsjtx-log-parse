use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Exception;
use Data::Dumper;

require Ham::WSJTX::Logparse;

# Loads up the sample modern test file
my $testh = Ham::WSJTX::Logparse->new("t/test-modern-all.txt");
ok($testh);
my $count = 0;
my @callsigns = ();
my @grids = ();
my @freqs = ();
my @powers = ();
my $callback = sub {
    my $date = shift;
    my $time = shift;
    my $power = shift;
    my $offset = shift;
    my $mode = shift;
    my $callsign = shift;
    my $grid = shift;
    my $freq = shift;
    $count++;
    push @callsigns, $callsign;
    push @grids, $grid;
    push @freqs, $freq;
    push @powers, $power;
};

$testh->parseForBand("40m", $callback);
is($count, 6);
is_deeply(\@callsigns, ['EC5KY', 'EA3HLM', 'YU7RIM', 'EA4MD', 'YU7RIM', 'IU2IZX']) or explain @callsigns;
is_deeply(\@grids, ['JN00', 'JN11', 'JN95', 'IN80', 'JN95', 'JN45']) or explain @grids;
is_deeply(\@freqs, ['7.074', '7.074', '7.074', '7.074', '7.074', '7.074']) or explain @freqs;
is_deeply(\@powers, ['0', '-21', '1', '-18', '-9', '-14']) or explain @powers;

done_testing;

1;
