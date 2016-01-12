package FiltreEx;
use strict;

sub new {

  my ($class,@exclure) = @_;

  my $ref = { 
    _exclure => \@exclure,
    _element_capture => 0,
  };


  bless $ref,$class;

}

sub exclure {

=item exclure(@aExclure)

  permet d'exclure les expressions du tableau



=cut

  my ($self,@exclure) = @_;
  $self->{_exclure} = \@exclure if @exclure;
  return @{$self->{_exclure}};


}

sub filtrer_chaine {

  my ($self,@chaine) = @_;

  my @ex = $self->exclure;

  my $jEx = @ex ? join("|",@ex) : '^ $';
  my @finalRes = grep { !/$jEx/ } @chaine;

  $self->{_element_capture} = scalar(@finalRes);

  @finalRes;

}

sub filtrage_est_reussi {
  my ($self) =@_;
  return 1 if $self->{_element_capture};
  return 0;
}
1;
