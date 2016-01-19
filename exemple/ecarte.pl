#!/usr/bin/env perl
use FiltreEx;
use FiltreInc;
my @liste = ("15","16","17","18");
my $choix = "15|16|20";
my $filtre = FiltreInc->new();
my $exf = FiltreEx->new();
$filtre->inclure("15");
$filtre->inclure("16");
$filtre->inclure("20");
$exf->exclure("16");
my @resultat = grep {/$choix/} @liste;
my @resFiltre = $filtre->filtrer_chaine(@liste);
print "resN : ",@resultat,"\n";
print "resF : ",@resFiltre,"\n";
$exf->filtrer_chaine(@resFiltre);
if ($exf->filtrage_est_reussi) {
    print "OK";
}
