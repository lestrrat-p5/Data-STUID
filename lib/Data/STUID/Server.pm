package Data::STUID::Server;
use strict;
use base qw(Net::Server::PreFork);
use Data::STUID;
use Data::STUID::Generator;
use IO::Handle;
use Class::Accessor::Lite
    rw => [ qw(generator host_id) ]
;

sub pre_loop_hook {
    my $self = shift;
    if (Data::STUID::DEBUG) {
        $self->log(2, "Create a new generateor");
    }
    my $generator = Data::STUID::Generator->new(host_id => $self->host_id);
    $generator->prepare;
    $self->generator($generator);
}

sub pre_server_close_hook {
    my $self = shift;
    if (Data::STUID::DEBUG) {
        $self->log(2, "Cleaning up generateor");
    }
    $self->generator()->cleanup;
    $self->generator(undef);
}

sub process_request {
    my $self = shift;

    while (read(STDIN, my $buf, 1) == 1) {
        my $id = $self->generator->create_id;
        if (Data::STUID::DEBUG) {
            $self->log(2, "Generated ID: $id");
        }
        print STDOUT pack("Q", $id);
        STDOUT->flush();
    }
}

1;

__END__

=head1 NAME

Data::STUID::Server - Simplistic STUID Server

=head1 SYNOPSIS

    use Data::STUID::Server;

    Data::STUID::Server->run(
        host_id => 1, # must be unique
    );

=head1 DESCRIPTION

Data::STUID::Server is a very simplistic server that implements a unique
ID generator. The ONLY thing this server can do is to generate a unique ID:
Nothing else. 

All you need to do is to send this server I<some> data. For each byte received,
Data::STUID::Server will just give you a 64-bit ID.

=head1 SETTING UP

=over 4

=item Install dependencies

install carton >= 0.9.10, and cpanm >= 1.60002.

    cd /path/to/Data-STUID
    carton install
    # optionally, skip tests: 'PERL_CPANM_OPT=-n carton install'

=item Execute It!

    carton exec -I/path/to/Data-STUID/lib -- \
        /path/to/Data-STUID/script/stuid-server \
        --host_id=1

It might be easier if you wrap the above in a shell script, say server.sh:

    #!/bin/sh
    STUID_HOME=/path/to/Data-STUID
    exec \
        carton exec -I$STUID_HOME/lib -- \
        $STUID_HOME/script/stuid-server $@

Then execute it as:

    ./server.sh --host_id=1

Note that you need pass a unique C<host_id> parameter to each distinct STUID
server instance

=back

=cut