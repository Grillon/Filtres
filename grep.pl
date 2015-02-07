#!/usr/bin/env perl
use Filtre_Inc;
use Filtre_Ex;

=pod

=item exemple d'inclusion

my @exemple_avant_inclusion = ("nom Thierry","prenom Grillon","age xx","pays France");
my $inclusion = Filtre_Inc->new("nom","pays");
my @exemple_apres_inclusion = $inclusion->filtrer_chaine(@exemple_avant_inclusion);

=cut

my @exemple_avant_inclusion = ("nom Thierry","prenom Grillon","age xx","pays France");
my $inclusion = Filtre_Inc->new("nom","pays");
my @exemple_apres_inclusion = $inclusion->filtrer_chaine(@exemple_avant_inclusion);

=item exemple d'exclusion

my @exemple_apres_inclusion = $inclusion->filtrer_chaine(@exemple_avant_inclusion);
my $exclusion = Filtre_Ex->new("nom");
my @resultats = $exclusion->filtrer_chaine(@exemple_apres_inclusion);

=cut

my $exclusion = Filtre_Ex->new("nom");
my @resultats = $exclusion->filtrer_chaine(@exemple_apres_inclusion);

print "avant inclusion : @exemple_avant_inclusion\napres inclusion : @exemple_apres_inclusion\napres exclusion : @resultats\n";
