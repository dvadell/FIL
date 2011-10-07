#!/usr/bin/perl -w -T
use strict;
use warnings;

# daemonize the program. To debug, comment this line.
daemonize;

# http://www.webreference.com/perl/tutorial/9/3.html
sub daemonize {
    chdir '/'                 or die "Can't chdir to /: $!";
    open STDIN, '/dev/null'   or die "Can't read /dev/null: $!";
    open STDOUT, '>>/dev/null' or die "Can't write to /dev/null: $!";
    open STDERR, '>>/dev/null' or die "Can't write to /dev/null: $!";
    defined(my $pid = fork)   or die "Can't fork: $!";
    if ($pid) {
        open(PIDFILE, ">/var/run/relayasql.pid") or die "Can't write to /var/run/relayasql.pid: $!";
        print PIDFILE $pid;
        close(PIDFILE);
        exit;
    }
    setsid                    or die "Can't start a new session: $!";
    umask 0;
}

