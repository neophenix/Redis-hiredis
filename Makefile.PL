require 5.004 ;
use ExtUtils::MakeMaker 5.16 ;
use Config ;

my @parts = qw/hiredis net sds/;
my $cfiles = [ map { "lib-$_.c" } @parts ];
my $ofiles = join ' ', map { "lib-$_.o" } @parts;

WriteMakefile(
        NAME            => 'Redis::hiredis',
        AUTHOR          => 'Brian Clapper <bclapper@omniti.com>',
        ABSTRACT        => 'interact with Redis using the hiredis client',
        VERSION_FROM    => 'hiredis.pm',
        OBJECT          => "hiredis.o $ofiles",
        C               => $cfiles,
        OPTIMIZE        => $ENV{'OPTIMIZE'}
        );


