#!/usr/bin/env perl

use Commande;
use Filtre_Inc;
use Filtre_Ex;
use Filtre_Ligne;
use Filtre_Groupe;

my $commande = Commande->new("cat vgdisplay.data");
my ($rc, @resultat) = $commande->execute();
#my (@resultat) = $commande->sortie();
#$resultat[1] =~ /VG Name\s(.*)/;
#my $nom = $1;
#print "RC : $rc", "LST : \n $nom \n";

my $filtre = Filtre_Inc->new('^\s*VG\s+Name\s+(\S+)',"VG S","---");
my $filtre2 = Filtre_Ex->new("VG Status");
my $filtre3 = Filtre_Ligne->new("nom,valeur",'^\s*([[:alnum:]]+\s+[[:alnum:]]+)','.*','(\S+)');
my $filtre4 = Filtre_Groupe->new('^\s*VG\s+Name\s+(\S+)$','\s*--- Volume group ---\s*');
my $filtre5 = Filtre_Ligne->new("nom_vg",'VG Name','(\S+)');

#$commande->utiliser($filtre)->utiliser($filtre2)->utiliser($filtre3)->utiliser($filtre4);
$commande->utiliser($filtre5);
#$commande->utiliser($filtre4);
print "\n",$commande->sortie(),"\n";
print "-----\n";
my %H = %{$filtre3->readline()};
print $H{valeur};
print "\n";
my %J = %{$filtre3->readline()};
print $J{valeur};
my @gp = $filtre4->groupe($J{valeur});
print "\ngp\n";
print @gp;
print "filtre 5\n";
my %f5 = %{$filtre5->readline()};
while ($filtre5->readline()){
  print values %{$filtre5->readline()}
  
}
print values %f5;
