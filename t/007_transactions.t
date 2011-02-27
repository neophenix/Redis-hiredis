use Test::More tests => 14;
require_ok ( 'Redis::hiredis' );
my $h = Redis::hiredis->new();
isa_ok($h, 'Redis::hiredis');

SKIP: {
    skip "No REDISHOST defined", 12 if ( ! defined $ENV{'REDISHOST'} );

    my $host = $ENV{'REDISHOST'};
    my $port = $ENV{'REDISPORT'} || 6379;

    my $r;
    my $c = $h->connect($host, $port);
    is($c, undef, 'connect success');

    my $prefix = "Redis-hiredis-$$-";

    $r = $h->command('multi');
    is($r, 'OK', 'multi');

    $h->command("set ".$prefix."foo foo");
    $h->command("set ".$prefix."bar bar");
    $h->command("set ".$prefix."baz baz");

    $r = $h->command('exec');
    ok(ref $r eq 'ARRAY', 'exec');
    is($r->[0], 'OK', 'exec 0');
    is($r->[1], 'OK', 'exec 1');
    is($r->[2], 'OK', 'exec 2');


    $h->command('multi');
    $h->command("set ".$prefix."foo bar");
    $r = $h->command('discard');
    is($r, 'OK', 'discard');

    $r = $h->command('get '.$prefix.'foo');
    is($r, 'foo', 'discard');

    $h->command('multi');
    $h->command('lpush '.$prefix."lfoo foo");
    $h->command('lpush '.$prefix."lfoo bar");
    $h->command('lpush '.$prefix."lfoo baz");
    $r = $h->command('exec');
    ok(ref $r eq 'ARRAY', 'list exec');
    is($r->[0], 1, 'list exec 0');
    is($r->[1], 2, 'list exec 1');
    is($r->[2], 3, 'list exec 2');
};
