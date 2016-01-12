#!/usr/bin/env perl
use inventaire;
chdir "/home/otvy8405/mesProjets/Projet_PreRequisReboot/env_test/Linux/pnexpl02/";
my $sig = "/home/otvy8405/mesProjets/Projet_PreRequisReboot/env_test/Linux/pnexpl01".`sign`;
chomp($sig);
my $inv = inventaire->new((nsh_dir => $sig));
#print $inv->nsh_dir;
$inv->get_version("os");
