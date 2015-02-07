package Filtre_Ex;

sub new {

  my ($class,@exclure) = @_;

  my $ref = { _exclure => \@exclure };


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

  @finalRes;

}
1;
