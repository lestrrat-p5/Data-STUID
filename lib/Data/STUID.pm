package Data::STUID;
use strict;
use constant DEBUG => !!$ENV{DATA_STUID_DEBUG};
our $VERSION = '0.01';

1;

__END__

=head1 NAME

Data::STUID - Yet Another Unique ID Generator

=head1 SYNOPSIS

    # see Data::STUID::Server
    #     Data::STUID::Client
    #     Data::STUID::Generator

=head1 DESCRIPTION

Minimalistic unique ID generator. Main logic ported from STF (http://github.com/stf-storage/stf).

The generated IDs are always in 64bit range, and can be ordered sequentially, so it's easy to use for sort operations.

=cut
