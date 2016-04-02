# -*- Perl -*-
#
# Pitch numbers from the ABC notation for notes, in a distinct module as
# the format is Case Sensitive, and the accidentals very different from
# those seen in other notation formats.
#
# Run perldoc(1) on this file for additional documentation.

package Music::PitchNum::ABC;

use 5.010000;
use Moo::Role;
use POSIX qw/floor/;
use Scalar::Util qw/looks_like_number/;

our $VERSION = '0.08';

##############################################################################
#
# ATTRIBUTES

has NOTE2NUM => (
  is      => 'rw',
  default => sub {
    { C => 0,
      D => 2,
      E => 4,
      F => 5,
      G => 7,
      A => 9,
      B => 11,
    };
  },
);

# ABC is like ASPN only for some N+1 reason it uses a different
# accidental form, sigh
has NUM2NOTE => (
  is      => 'rw',
  default => sub {
    { 0  => 'C',
      1  => '^C',
      2  => 'D',
      3  => '^D',
      4  => 'E',
      5  => 'F',
      6  => '^F',
      7  => 'G',
      8  => '^G',
      9  => 'A',
      10 => '^A',
      11 => 'B',
    };
  },
);

has ignore_octave => (
  is     => 'rw',
  coerce => sub {
    $_[0] ? 1 : 0;
  },
  default => 0,
);

##############################################################################
#
# METHODS

sub pitchname {
  my ( $self, $number ) = @_;
  die "need a number for pitchname\n" if !looks_like_number $number;

  my $octave = floor( $number / 12 ) - 1;
  my $note   = $self->NUM2NOTE->{ $number % 12 };

  if ( !$self->ignore_octave ) {
    $note = lc $note if $octave > 4;
    $note .= (q{'}) x ( $octave - 5 ) if $octave > 5;
    $note .= (q{,}) x ( 4 - $octave ) if $octave < 4;
  }

  return $note;
}

sub pitchnum {
  my ( $self, $name ) = @_;

  # already a pitch number, but nix the decimal foo
  return int $name if looks_like_number $name;

  my $pitchnum;

  if ( $name =~
    m/ (?<chrome> (?: [_]{1,2} | [\^]{1,2} ) )? (?: (?<note>[A-G])(?<octave>[,]+)? | (?<note>[a-g])(?<octave>[']+)? ) /x
    ) {
    my $octave = $+{octave};
    my $chrome = $+{chrome};
    my $note   = $+{note};

    $pitchnum = $self->NOTE2NUM->{ uc $note } + 12 * ( $note =~ m/[A-G]/ ? 5 : 6 );

    if ( defined $octave ) {
      $pitchnum += 12 * length($octave) * ( $octave =~ m/[,]/ ? -1 : 1 );
    }

    if ( defined $chrome ) {
      $pitchnum += length($chrome) * ( $chrome =~ m/[_]/ ? -1 : 1 );
    }
  }

  return $pitchnum;
}

1;
__END__

##############################################################################
#
# DOCS

=head1 NAME

Music::PitchNum::ABC - note name and pitch number roles for ABC notation

=head1 SYNOPSIS

  package MyCleverMouse;
  use Moo;
  with('Music::PitchNum::ABC');
  ...

Then elsewhere:

  use MyCleverMouse;
  my $x = MyCleverMouse->new;

  $x->pitchname(69);    # A
  $x->pitchnum('A');    # 69

=head1 DESCRIPTION

A L<Music::PitchNum> implementation specifically for the ABC notation,
which varies from the other notation forms by using case sensitive
letters to denote octave indications, otherwise falling back to the
Helmholtz form outside the range around middle C (via C<,> and C<'>
marks). Oh, and the accidental notation is also totally different from
the other forms.

This module is expected to be used as a Role from some other module;
L<Moo::Role> may be informative.

=head1 ATTRIBUTES

Just one, B<ignore_octave> which if true (false by default) will cause
calls to B<pitchname> to omit the octave indication and return just a
plain note.

=head1 METHODS

=over 4

=item B<pitchname> I<pitchnumber>

Returns the pitch name for the given integer, though will throw an
exception if passed something that is not a number.

=item B<pitchnum> I<pitchname>

Returns the pitch number for the given ABC note name, or C<undef> if the
note could not be parsed.

=back

=head1 BUGS

=head2 Reporting Bugs

Please report any bugs or feature requests to
C<bug-music-pitchnum at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Music-PitchNum>.

Patches might best be applied towards:

L<https://github.com/thrig/Music-PitchNum>

=head2 Known Issues

None known for the ABC notation support.

=head1 SEE ALSO

L<Music::PitchNum>

=head2 REFERENCES

L<http://abcnotation.com/examples>

=head1 AUTHOR

thrig - Jeremy Mates (cpan:JMATES) C<< <jmates at cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014-2016 by Jeremy Mates

This module is free software; you can redistribute it and/or modify it
under the Artistic License (2.0).

=cut
