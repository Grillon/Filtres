#!/usr/bin/env perl

use Filtre_Ligne;

=pod

=item groupe les elements constituant une ligne

ls -l
total 52
-rw-r--r-- 2 username groupname  2446 Dec  5 10:00 Commande.pm
-rw-r--r-- 1 username groupname   514 Dec  5 10:00 Filtre_Ex.pm
-rw-r--r-- 1 username groupname  1480 Dec  5 10:00 Filtre_Groupe.pm
-rw-r--r-- 1 username groupname   536 Dec  5 10:00 Filtre_Inc.pm
-rw-r--r-- 1 username groupname  1925 Dec  5 10:00 Filtre_Ligne.pm
-rw-r--r-- 1 username groupname 18027 Dec  5 10:00 LICENSE
-rwxr-xr-x 2 username groupname  3279 Dec  5 10:00 README.md
-rwxr-xr-x 1 username groupname   994 Dec  5 10:00 grep.pl

pour l'exemple je mets manuellement le resultat du ls dans une liste mais un `ls -l` fait l'affaire;

my @sortie = ('total 52',
'-rw-r--r-- 2 username groupname  2446 Dec  5 10:00 Commande.pm',
'-rw-r--r-- 1 username groupname   514 Dec  5 10:00 Filtre_Ex.pm',
'-rw-r--r-- 1 username groupname  1480 Dec  5 10:00 Filtre_Groupe.pm',
'-rw-r--r-- 1 username groupname   536 Dec  5 10:00 Filtre_Inc.pm',
'-rw-r--r-- 1 username groupname  1925 Dec  5 10:00 Filtre_Ligne.pm',
'-rw-r--r-- 1 username groupname 18027 Dec  5 10:00 LICENSE',
'-rwxr-xr-x 2 username groupname  3279 Dec  5 10:00 README.md',
'-rwxr-xr-x 1 username groupname   994 Dec  5 10:00 grep.pl');

my $groupes = '([r\-wx]+)\s+([0-9]+)\s+([[:alnum:]]+)\s+([[:alnum:]]+)\s+([0-9]+)\s+([0-9]+\s+[[:alnum:]]+.\s+[0-9\:]+)\s+(.*)';
my $nom_groupes = 'droits,liens,user,group,taille,date,fichier';

my $ls = Fitre_Ligne->new($nom_groupes,$groupes);

=cut


my @sortie = ('total 52',
'-rw-r--r-- 2 username groupname  2446 Dec  5 10:00 Commande.pm',
'-rw-r--r-- 1 username groupname   514 Dec  5 10:00 Filtre_Ex.pm',
'-rw-r--r-- 1 username groupname  1480 Dec  5 10:00 Filtre_Groupe.pm',
'-rw-r--r-- 1 username groupname   536 Dec  5 10:00 Filtre_Inc.pm',
'-rw-r--r-- 1 username groupname  1925 Dec  5 10:00 Filtre_Ligne.pm',
'-rw-r--r-- 1 username groupname 18027 Dec  5 10:00 LICENSE',
'-rwxr-xr-x 2 username groupname  3279 Dec  5 10:00 README.md',
'-rwxr-xr-x 1 username groupname   994 Dec  5 10:00 grep.pl');

my $groupes = '([r\-wx]+)\s+([0-9]+)\s+([[:alnum:]]+)\s+([[:alnum:]]+)\s+([0-9]+)\s+([0-9]+\s+[[:alnum:]]+.\s+[0-9\:]+)\s+(.*)';
my $nom_groupes = 'droits,liens,user,group,taille,date,fichier';

my $ls = Filtre_Ligne->new($nom_groupes,$groupes);

$ls->filtrer_chaine(@sortie);
print $ls->groupe;
while ($ls->groupe) {
    foreach my $nom ($ls->groupe) {
      print $ls->groupe($nom);
    }
    print "\n";
    $ls->suivant;
  }
