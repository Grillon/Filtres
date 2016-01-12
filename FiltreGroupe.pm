package FiltreGroupe;
use strict;

sub new {
  my ($class,$titre,$debut,$fin) = @_;

  $fin = $debut unless defined $fin;
  my $separateur = '\s+';

  my $ref = {
    _titre => $titre,
    _debut => $debut,
    _fin => $fin,
    _separateur => $separateur,
    _element_capture => 0,
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

my $groupement_non_delim = sub {
  my ($debut,$fin,$titre) = @_;
  my @groupe;
  my @nom_groupe;
  my $nom;
  my $zone = 'ex';
  my $ligne;
  my $x = 0;

  return sub {
    my ($nl,$action) = @_;

    if (defined $action) {
      my $choix = {
	groupe => return @groupe,
	nom => return @nom_groupe,
      };
      return $choix->{$action};
    }

    if ($nl =~ $titre) {
      unless ($nom) {
	$nom = $1;
	push @nom_groupe,$nom;
      }
      

    }

    if ($zone =~ 'mil') {
      if ($nl =~ $debut) {
	$zone = 'ex';
	$nom = "";
	#push @groupe,$ligne;

      }
      else {
	@groupe[-1] .= " ".$nl;
      }
    }
    if ($zone =~ 'ex') {
      if ($nl =~ $debut) {
	$zone = 'in';
      }
    }
    if ($zone =~ 'in') {
      push @groupe,$nl;
      $zone = 'mil';
      $x +=1;
    }
    #print "$x $zone : $nl\n";
    @groupe;
  }

};

my $groupement = sub {
  my ($debut,$fin,$titre) = @_;
  my @groupe;
  my $zone = 'ex';
  my $ligne;
  my $x = 0;

  return sub {
    my ($nl) = @_;

      if ($zone =~ 'ex') {
	if ($nl =~ $debut) {
	  $zone = 'in';
	}
      }
      #print "$x $zone : $nl\n";
      if ($zone =~ 'in') {
	$ligne = $ligne." ".$nl;
	if ($nl =~ $fin) {
	  push @groupe,$ligne;
	  $zone = 'ex';
	  $ligne = "";
	  $x +=1;


	}
      }
    @groupe;
  }

};

sub filtrer_chaine {
  my ($self,@chaine) = @_;
  my $debut = $self->{_debut};
  my $fin = $self->{_fin};
  my $titre = $self->{_titre};
  my $resultats = $groupement_non_delim->($debut,$fin,$titre);
  my @groupe;

  foreach my $ligne (@chaine) {
    @groupe = $resultats->($ligne);
  }
  
  $self->{_capture} = \@groupe;

}




sub filtrage_est_reussi {
  my ($self) = @_;
  return $self->{_element_capture} if $self->{_element_capture};
  return 0;
}

sub groupe {
  my ($self,$groupe) = @_;
  my @groupes = @{$self->{_capture}};
  #return @{$groupes{$groupe}} if defined $groupe;
}

1;
