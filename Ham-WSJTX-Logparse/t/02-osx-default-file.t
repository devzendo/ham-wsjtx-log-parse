use strict;
use warnings FATAL => 'all';
use Test::More;
use Test::Exception;
use Data::Dumper;

require Ham::WSJTX::Logparse;

# No-arg constructor; the default file (which exists on my OSX test system)
my $h = Ham::WSJTX::Logparse->new();
my @files = $h->files();

ok(scalar(@files) == 1);

ok($files[0] =~ /ALL\.TXT$/);

done_testing;

1;
