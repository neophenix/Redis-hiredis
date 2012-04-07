use strict;
use warnings;
use Test::More;
use IO::Socket::INET;

plan skip_all => q/$ENV{'REDISHOST'} isn't set/ 
    if !defined $ENV{REDISHOST};

{
    use_ok 'Redis::hiredis';
    my $h = Redis::hiredis->new();
    isa_ok($h, 'Redis::hiredis');

    my $host = $ENV{'REDISHOST'};
    my $port = $ENV{'REDISPORT'} || 6379;

    my $s = IO::Socket::INET->new(
        PeerHost => $host,
        PeerPort => $port
    );

    my $c = $h->connect_fd($s->fileno);
    is($c, undef, 'connect success');

    my $r;
    $r = $h->command('ping');
    is $r, 'PONG', 'reply of ping command';
}

done_testing;
