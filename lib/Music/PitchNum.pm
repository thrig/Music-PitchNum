# -*- Perl -*-
#
# Utility music pitch name to number routines, mostly motivated by not wanting
# to drag in my huge and crufty Music::LilyPondUtil module just to figure out
# what pitch number "a'" is, and providing for such as a Role.

package Music::PitchNum;

use 5.010000;

use Role::Tiny;

our $VERSION = '0.01';

##############################################################################
#
# METHODS

# TODO

1;

__END__

##############################################################################
#
# DOCS

=head1 NAME

Music::PitchNum - note name to pitch number utility roles

=head1 SYNOPSIS

  TODO

See also the C<eg/> and C<t/> directories of the distribution of this module
for example code.

=head1 DESCRIPTION

TODO

=head1 METHODS

TODO

=head1 BUGS

=head2 Reporting Bugs

Please report any bugs or feature requests to
C<bug-music-pitchnum at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Music-PitchNum>.

Patches might best be applied towards:

L<https://github.com/thrig/Music-PitchNum>

=head2 Known Issues

The being not yet written part.

=head1 AUTHOR

thrig - Jeremy Mates (cpan:JMATES) C<< <jmates at cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Jeremy Mates

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.20 or, at your option, any
later version of Perl 5 you may have available.

=cut
