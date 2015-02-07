package Filtre_Inc;

sub new {
  my ( $class,@inclure ) = @_;

  my $ref = {_inclure => \@inclure};

  bless $ref,$class;

}

sub inclure {

=item inclure(@aInclure)

  permet d'inclure les expressions du tableau



=cut

  my ($self,@inclure) = @_;
  $self->{_inclure} = \@inclure if @inclure;
  return @{$self->{_inclure}};


}


sub filtrer_chaine {
  my ($self,@chaine) = @_;

  my @finalRes;

  my @inc = $self->inclure;


  my $incs = @inc ? join("|",@inc) : '.*';
  my @finalRes = grep { /$incs/ } @chaine;


  @finalRes;
}


1;
