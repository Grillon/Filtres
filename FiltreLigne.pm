package FiltreLigne;

sub new {
  my ($class,$titre,@regex) = @_;

  my $separateur = '\s*' unless defined;

  my @titres = split(",",$titre);

  my $ref = {
    _titres => \@titres,
    _regex => \@regex,
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

sub ajout_ligne {
  my ($self,$titre,$regex) = @_;
  my @titres = split(",",$titre);
  if (defined $titre && defined $regex) {
    $regex = '|'.$regex;
    push @{$self->{_titres}},@titres;
    push @{$self->{_regex}},$regex;
  }

}

sub filtrer_chaine {
  no strict;
  my ($self,@chaine) = @_;
  my $regex = $self->regex;
  my @titres = @{$self->{_titres}};
  my @resultats;
  my %resultat;

my $y = 0;
my $def = -1;
  foreach my $ligne (@chaine) {
    my $x = 0;
    $ligne =~ s/^\s+$//;
    unless ($ligne =~ $regex) {
      next;

    }
    foreach my $element (@titres) {
      $x++;
      if (defined $$x) {
	if ((defined $resultat{$element}) && ($def != $y)) {
	  my %res_tmp = %resultat;
	  foreach my $cle (keys %resultat) {
	    delete $resultat{$cle};
	  }
	  push @resultats,\%res_tmp if %res_tmp;
	  $resultat{$element} = $$x;
	}
	elsif ((defined $$x) && ($def == $y)) {
	  $resultat{$element} = $$x;
	}
	else {
	  $resultat{$element} = $$x;
	  $def = $y;
	}
      }
    }
    $y++;
  }
  push @resultats,\%resultat if %resultat;

  $self->{_element_capture} = scalar(@resultats);

  $self->{_capture} = \@resultats;
  $self->ajout_index;
  @chaine;
}

sub ajout_index {
  my ($self) = @_;
  my $x = 0;
  foreach my $groupe ($self->tous) {
    $groupe->{index} = $x++;
  }
}

sub filtrage_est_reussi {
  my ($self) =@_;
  return 1 if $self->{_element_capture};
  return 0;
}

sub groupe {
  my ($self,$nom) = @_;
  my @capture = @{$self->{_capture}};
  my $ligne = shift @capture;
  return keys %{$ligne} unless defined $nom;
  $ligne->{$nom};
}

sub suivant {
  my ($self) = @_;
  #print scalar @{$self->{_capture}};
  my $ligne = shift @{$self->{_capture}};
}

sub tous {
  my ($self) = @_;
  return @{$self->{_capture}};

}

1;
