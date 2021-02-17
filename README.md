[![Build Status](https://travis-ci.org/powerman/perl-MojoX-Log-Fast.svg?branch=master)](https://travis-ci.org/powerman/perl-MojoX-Log-Fast)
[![Coverage Status](https://coveralls.io/repos/powerman/perl-MojoX-Log-Fast/badge.svg?branch=master)](https://coveralls.io/r/powerman/perl-MojoX-Log-Fast?branch=master)

# NAME

MojoX::Log::Fast - Log::Fast for Mojolicious

# VERSION

This document describes MojoX::Log::Fast version v1.2.0

# SYNOPSIS

    use MojoX::Log::Fast;

    $app->log( MojoX::Log::Fast->new() );

    $app->log->config(...);
    $app->log->ident(...);

# DESCRIPTION

This module provides a [Mojo::Log](https://metacpan.org/pod/Mojo::Log) implementation that uses [Log::Fast](https://metacpan.org/pod/Log::Fast)
as the underlying log mechanism. It provides Log::Fast methods config(),
ident() and all Mojo::Log methods except handle(), path() and format().

## LOG LEVELS

Mojo::Log's fatal() processed same as error() because Log::Fast doesn't
support that log level.

Log::Fast's NOTICE() level not available because Mojo::Log doesn't support
that log level.

# INTERFACE 

## new

        $log = MojoX::Log::Fast->new();
        $log = MojoX::Log::Fast->new( $logfast );

If Log::Fast instance $logfast doesn't provided then Log::Fast->global()
will be used by default.

## context

        my $new = $log->context('[extra] [information]');

Construct a new child [Mojo::Log::Fast](https://metacpan.org/pod/Mojo::Log::Fast) object that will include context information
with every log message.

        # Log with context
        my $log = Mojo::Log::Fast->new;
        my $context = $log->context('[17a60115]');
        $context->debug('This is a log message with context information');
        $context->info('And another');

## config

## ident

        $log->config( @params );
        $log->ident( @params );

Proxy these methods with given @params to Log::Fast instance.

## handle

## path

Not compatible with Log::Fast and thus not supported.

## format

Not implemented yet, use much more flexible config() instead.

Let me know if you needs it.

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at [https://github.com/powerman/perl-MojoX-Log-Fast/issues](https://github.com/powerman/perl-MojoX-Log-Fast/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.
Feel free to fork the repository and submit pull requests.

[https://github.com/powerman/perl-MojoX-Log-Fast](https://github.com/powerman/perl-MojoX-Log-Fast)

    git clone https://github.com/powerman/perl-MojoX-Log-Fast.git

## Resources

- MetaCPAN Search

    [https://metacpan.org/search?q=MojoX-Log-Fast](https://metacpan.org/search?q=MojoX-Log-Fast)

- CPAN Ratings

    [http://cpanratings.perl.org/dist/MojoX-Log-Fast](http://cpanratings.perl.org/dist/MojoX-Log-Fast)

- AnnoCPAN: Annotated CPAN documentation

    [http://annocpan.org/dist/MojoX-Log-Fast](http://annocpan.org/dist/MojoX-Log-Fast)

- CPAN Testers Matrix

    [http://matrix.cpantesters.org/?dist=MojoX-Log-Fast](http://matrix.cpantesters.org/?dist=MojoX-Log-Fast)

- CPANTS: A CPAN Testing Service (Kwalitee)

    [http://cpants.cpanauthors.org/dist/MojoX-Log-Fast](http://cpants.cpanauthors.org/dist/MojoX-Log-Fast)

# AUTHOR

Alex Efros <powerman@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2013- by Alex Efros <powerman@cpan.org>.

This is free software, licensed under:

    The MIT (X11) License
