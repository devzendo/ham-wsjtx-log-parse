use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Exception;
use Data::Dumper;

require Ham::WSJTX::Logparse;

# Specific file constructor; dies if file doesn't exist.
dies_ok { Ham::WSJTX::Logparse->new("/nonexistent/file/ALL.TXT") };


# Loads up the sample test file
my $testh = Ham::WSJTX::Logparse->new("t/test-all.txt");
ok($testh);
my $count = 0;
my @callsigns = ();
my @grids = ();
my $callback = sub {
    my $date = shift;
    my $time = shift;
    my $power = shift;
    my $offset = shift;
    my $mode = shift;
    my $callsign = shift;
    my $grid = shift;
    $count++;
    push @callsigns, $callsign;
    push @grids, $grid;
};

$testh->parseForBand("20m", $callback);
is($count, 4);
is_deeply(\@callsigns, ['LZ1UBO', 'WA4RG', 'AE4DR', 'RN6MG']) or explain @callsigns;
is_deeply(\@grids, ['KN12', 'EM82', 'EM85', 'LN08']) or explain @grids;

done_testing;

1;
