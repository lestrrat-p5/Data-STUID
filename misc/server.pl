use strict;
use Data::STUID::Server;

Data::STUID::Server->run(
    port => $ARGV[1] || 9001,
    host => '127.0.0.1',
    host_id => $ARGV[0],
);