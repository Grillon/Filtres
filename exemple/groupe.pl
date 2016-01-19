#!/usr/bin/env perl
#my $chaine = "-rw-r--r--  1 thierry staff     24651 23 dec.  22:30 subtle-2014-12-23-20-30.log";
#my $ligne = "droits,liens,user,group,taille,date,nom";
#my $chaine = "Metadata Sequence No  12";
my $chaine = " Free  PE / Size       16582 / 64,77 GiB";
my $ligne = "nom,valeur";
#my $groupes = '([r\-wx]+)\s+([0-9]+)\s+([[:alnum:]]+)\s+([[:alnum:]]+)\s+([0-9]+)\s+([0-9]+\s+[[:alnum:]]+.\s+[0-9\:]+)\s+(.*)';
#my @groupess = ('([r\-wx]+)','([0-9]+)','([[:alnum:]]+)','([[:alnum:]]+)','([0-9]+)','([0-9]+\s+[[:alnum:]]+.\s+[0-9\:]+)','(.*)');
my @groupess = ('^\s*(VG N|VG S)','.*','(\S+)');
my $sep = '\s+';
my $groupes = join($sep,@groupess);
#print $groupes;
$chaine =~ $groupes;
my $droit = $7;
my $x = 0;
my %resultat;
#print $droit;
my @elements = split(",",$ligne);
foreach $element (@elements) {
  $x++;
  $resultat{$element} = $$x;
}
print keys %resultat;
#print "\n$resultat{droits}";
print "\n$resultat{valeur}";
