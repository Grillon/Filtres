package Filtre_Groupe;

sub new {
  my ($class,$titre,$debut,$fin) = @_;

  $fin = $debut unless defined $fin;
  my $separateur = '\s+';

  my $ref = {
    _titre => $titre,
    _debut => $debut,
    _fin => $fin,
    _separateur => $separateur,
  };


  bless $ref,$class;

}

sub separateur {
  my ($self,$sep) = @_;
  return $self->{_separateur} unless defined $sep;
  $self->{_separateur} = $sep;
  $self->{_separateur};
}

sub regex {
  my ($self) = @_;
  my $sep = $self->separateur;
  my @regex = @{$self->{_regex}};
  my $groupes = join($sep,@regex);
}

sub filtrer_chaine {
  my ($self,@chaine) = @_;
  my $debut = $self->{_debut};
  my $fin = $self->{_fin};
  my $titre = $self->{_titre};
  my %resultats;
  my @groupe;
  my $zone = 'ex';
  my $nom;
  

  foreach my $ligne (@chaine) {
    if ($ligne =~ $fin) {
      if (defined $nom) {
	push @groupe,$ligne;
	push @{$resultats{$nom}},@groupe;
	@groupe = ();
	$zone='ex';
	$nom = "";
      }
       }
      if ($ligne =~ $debut) {
	$zone = 'in';
	push @groupe,$ligne;

      }
      elsif ($zone =~ /in/) {
	push @groupe,$ligne;
      }
      if ($ligne =~ $titre) {
	$nom = $1;
      }

    }
  if (defined $nom) {
	push @{$resultats{$nom}},@groupe if scalar(@groupe)>0;
	@groupe = ();
	$zone='ex';
	$nom = "";


  }

  $self->{_capture} = \%resultats;
  @chaine;
}

sub groupe {
  my ($self,$groupe) = @_;
  my %groupes = %{$self->{_capture}};
  return @{$groupes{$groupe}} if defined $groupe;
  keys %groupes;
}

1;
