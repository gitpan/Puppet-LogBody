############################################################
#
# $Header: /mnt/barrayar/d06/home/domi/Tools/perlDev/Puppet_LogBody/RCS/LogBody.pm,v 1.2 1999/08/10 12:39:59 domi Exp $
#
# $Source: /mnt/barrayar/d06/home/domi/Tools/perlDev/Puppet_LogBody/RCS/LogBody.pm,v $
# $Revision: 1.2 $
# $Locker:  $
# 
############################################################

package Puppet::LogBody ;

use Carp ;

use strict ;
use vars qw($VERSION) ;

$VERSION = sprintf "%d.%03d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/;

# see loadspecs for other names
sub new 
  {
    my $type = shift ;
    my $self = {} ;
    my %args = @_ ;

    $self->{name} = $args{'name'} ; #complete log name

    $self->{how}  = $args{'how'} ;

    $self->{'data'}= [] ;

    bless $self,$type ;
  }

sub log
  {
    my $self = shift ;
    my $text = shift ;
    my %args = @_ ;

    my $how = exists $args{'how'} ? $args{how} : $self->{how};

    chomp ($text) ;
    $text .= "\n";

    push @{$self->{'data'}}, $text ; # always keep text in local array

    if (defined $how)
      {
        my $str = defined $self->{name} ? $self->{name}.": \n\t" : '';
        $str .= $text;
        if ($how eq 'print')   {print $str ;}
        elsif ($how eq 'warn') {warn  $str ;}
      } 
    return $text ;
  }

sub clear
  {
    my $self = shift ;
    $self->{'data'} =[];
  }

sub getAll
  {
    my $self = shift ;
    return @{$self->{'data'}} ;
  }

1;

__END__

=head1 NAME

Puppet::LogBody - Log facility

=head1 SYNOPSIS

 use Puppet::LogBody ;

 my $log = new Puppet::LogBody 
  ( 
   name => 'log test', 
   'how' => 'print'
  ) ;

 $log -> log("hello")  ;                 # printed on STDOUT
 $log -> log("world",'how' => 'warn')  ; # printed on STDERR

 my @a = $log-> getAll() ; # @a contains ['hello','world']

=head1 DESCRIPTION

This class implements a log facility which can either print on STDOUT
or warn on STDERR (or hide) the log message. But in any case, the log
message will be stored in the class so that all log messages can be
retrieved later by the user.

=head1 Constructor

=head2 new (...)

Creates the log object. 

Parameters are

=over 4

=item *

name: is the log name that will be printed on STDERR or STDOUT at each
log. (optional)


=item *

how: specifies what  to do when a log   is sent to the  object (either
print  on STDOUT, warn  on  STDERR). By default  the logs  will not be
printed or warned.

=back

For instance if name is set to 'foo' a call to log('hello') will print:

 foo:
       hello

=head1 Methods

As Puppet::LogBody inherits from Puppet::Log, all the parent methods are 
available. 

=head2 log(text,...)

Will log the passed text

Optional parameters are:

=over 4

=item *

how: will supersede the 'how' parameter passed to the constructor. If
'how' is set to undef, the log will not be printed or warned.

=back

=head2 clear()

Clear all stored logs

=head2 getAll()

Return an array made of all stored logs.

=head1 About Puppet body classes

Puppet classes are a set of utility classes which can be used by any object.
If you use directly the Puppet::*Body class, you get the plain functionnality.
And if you use the Puppet::* class, you can get the same functionnality and
a Tk Gui to manage it. 

=head1 AUTHOR

Dominique Dumont, Dominique_Dumont@grenoble.hp.com

Copyright (c) 1998-1999 Dominique Dumont. All rights reserved.  This
program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

perl(1), Puppet::Log(3)

=cut
