use strict;
use Data::STUID::Client;

my $client = Data::STUID::Client->new(
    servers => [ qw(
        127.0.0.1:9001
        127.0.0.1:9002
    ) ]
);

my %seen;
for(1..100_000) {
    my $id =  $client->fetch_id;
    print "Got $id\n";
    if ($seen{$id}++) {
        print "Overloapped id $id\n";
    }
}