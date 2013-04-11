package MojoX::Log::Fast;

use strict;
use warnings;
use Carp 'croak';

use version; our $VERSION = qv('0.1.0');    # REMINDER: update Changes

# REMINDER: update dependencies in Build.PL
use Mojo::Base 'Mojo::Log';

use Log::Fast;


my %MapLevel = (
    debug   => 'DEBUG',
    info    => 'INFO',
    warn    => 'WARN',
    error   => 'ERR',
    fatal   => 'ERR',
);


sub new {
    my $self = shift->SUPER::new();
    $self->{'_logger'} = shift || Log::Fast->global();
    if ($ENV{MOJO_LOG_LEVEL}) {
        $self->level($ENV{MOJO_LOG_LEVEL});
    }
    $self->unsubscribe('message');
    $self->on(message => \&_message);
    return $self;
}

## no critic(RequireArgUnpacking)
sub config  { return shift->{'_logger'}->config(@_); }
sub ident   { return shift->{'_logger'}->ident(@_); }

sub handle  { croak q{log->handle: not supported, use log->config} };
sub path    { croak q{log->path: not supported, use log->config} };
sub format  { croak q{log->format: not implemented} }; ## no critic(ProhibitBuiltinHomonyms)

sub level {
    if (@_ == 1) {
        return $_[0]{'level'} if exists $_[0]{'level'};
        return $_[0]{'level'} = 'debug';
    }
    $_[0]{'level'} = $ENV{MOJO_LOG_LEVEL} || $_[1];
    $_[0]{'_logger'}->level($MapLevel{ $ENV{MOJO_LOG_LEVEL} || $_[1] });
    return $_[0];
}

sub _message {
    my ($self, $level, @lines) = @_;
    given ($level) {
        ## no critic(ProhibitPostfixControls)
        $self->{'_logger'}->DEBUG(join "\n", @lines)  when q{debug};
        $self->{'_logger'}->INFO(join "\n", @lines)   when q{info};
        $self->{'_logger'}->WARN(join "\n", @lines)   when q{warn};
        $self->{'_logger'}->ERR(join "\n", @lines);   # error, fatal
    }
    return;
}

1; # Magic true value required at end of module
__END__

=encoding utf8

=head1 NAME

MojoX::Log::Fast - Log::Fast for Mojolicious


=head1 SYNOPSIS

    use MojoX::Log::Fast;

    $app->log( MojoX::Log::Fast->new() );

    $app->log->config(...);
    $app->log->ident(...);


=head1 DESCRIPTION

This module provides a L<Mojo::Log> implementation that uses L<Log::Fast>
as the underlying log mechanism. It provides Log::Fast methods config(),
ident() and all Mojo::Log methods except handle(), path() and format().

=head2 LOG LEVELS

Mojo::Log's fatal() processed same as error() because Log::Fast doesn't
support that log level.

Log::Fast's NOTICE() level not available because Mojo::Log doesn't support
that log level.


=head1 INTERFACE 

=over

=item new( [$logfast] )

If Log::Fast instance $logfast doesn't provided then Log::Fast->global()
will be used by default.

=item config( @params )

=item ident( @params )

Proxy these methods with given @params to Log::Fast instance.

=item handle()

=item path()

Not compatible with Log::Fast and thus not supported.

=item format()

Not implemented yet, use much more flexible config() instead.

Let me know if anyone need it.

=back


=head1 BUGS AND LIMITATIONS

No bugs have been reported.


=head1 SUPPORT

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MojoX-Log-Fast>.
I will be notified, and then you'll automatically be notified of progress
on your bug as I make changes.

You can also look for information at:

=over

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MojoX-Log-Fast>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MojoX-Log-Fast>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MojoX-Log-Fast>

=item * Search CPAN

L<http://search.cpan.org/dist/MojoX-Log-Fast/>

=back


=head1 AUTHOR

Alex Efros  C<< <powerman@cpan.org> >>


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Alex Efros <powerman@cpan.org>.

This program is distributed under the MIT (X11) License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

