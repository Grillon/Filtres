package Commande;

=pod

=head1 Classe Commande

=head2 NOM

Commande - Ce module permet d'executer une commande et de filtrer la sortie.


=head2 SYNOPSIS

use Commande;

my $commande = Commande->new("vgdisplay -v");

my (@resultat,$rc) = $commande->execute();

plus tard a tout moment on peut interoger le resultat ou le code de sortie via les commandes suivantes :

$commande->rc();
$commande->sortie();

ou reexecuter la commande :

$commande->execute();

NB : pour le moment j'utilise LANG=C je ne pense pas qu'il soit utile de redefinir ca mais je pourrais ajouter la methode si besoin.

=cut

=head2 DESCRIPTION

Cette classe est un essai. Je tente de changer mon mode de pens. AU lieu de penser comme en programmation classique ou en mode script je mixe :)
Souvent on grep/awk ou cut le resultat des commandes. On a parfois besoin du code de sortie.

=cut

=head2 FONCTIONS

=over 4

=cut


sub  new {

=item new("la commande");

  initialise un objet commande

=cut

  my ($class,$commande) = @_;

  $ref = {
    _commande => $commande,

  };

  bless $ref,$class;

}

sub commande {

  my ($self,$commande) = @_;
  $self->{_commande} = $commande if $commande;
  $self->{_commande};

}

sub execute {

=item execute()

  lance l'execution de la commande et renvoie $rc,@resultat



=cut

  my ($self,@arguments) = @_;
  my $cmd = $self->commande;
  my $arg_plat = join(" ",@arguments);
  my @tmpRes;
  my $lang = "LANG=C";
  my $err_code = 'echo $?';
  $cmd = "export $lang;$cmd $arg_plat;$err_code";
  my @retours = `$cmd`;

  map { chomp($_) } @retours;
  $err_code = pop @retours;
  $self->{_rc} = $err_code;
  $self->{_sortie} = \@retours;

  $err_code,@retours;
  #filtrage de la sortie
}

sub sortie {

=item sortie()

  renvoie la sortie de la commande sans la reexecuter sauf si la commande n'a jamais ete lancee

=cut

  my ($self) = @_;
  return @{$self->{_sortie}} if $self->{_sortie};
  $self->execute();
  @{$self->{_sortie}};

}

sub rc {

=item rc()

  renvoie le code de sortie de la commande sans la reexecuter sauf si la commande n'a jamais ete lancee

=cut


  my ($self) = @_;
  return $self->{_rc} if $self->{_rc};
  $self->execute();
  $self->{_rc};


}

sub passer_filtre {

  my ($self,$filtre) = @_;

  my @chaine = $self->sortie;

  @chaine = $filtre->filtrer_chaine(@chaine);

  $self->{_sortie} = \@chaine;
  $self;

}


=head2 AUTEUR


B<Thierry VOGEL> I<ORANGE/OF/DTSI/DESI/DIST/STX/PD>

B<2014>

=cut


1;
