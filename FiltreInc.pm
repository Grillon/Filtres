package FiltreInc;
use strict;

sub new {
  my ( $class,@inclure ) = @_;

  my $ref = {
    _inclure => \@inclure,
    _element_capture => 0,
  };

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

  $self->{_element_capture} = scalar(@finalRes);

  @finalRes;
}

sub filtrage_est_reussi {
  my ($self) =@_;
  return 1 if $self->{_element_capture};
  return 0;
}


1;
