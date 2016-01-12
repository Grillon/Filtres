#!/usr/bin/env perl

use Commande;
use Filtre_Inc;
use Filtre_Ex;
use Filtre_Ligne;
use Filtre_Groupe;

my $commande = Commande->new("cat vgdisplay.data");
my ($rc, @resultat) = $commande->execute();

my $vgs = Filtre_Groupe->new('^\s*VG\s+Name\s+(\S+)$','\s*--- Volume group ---\s*','\s*--- Logical volume ---\s*');
my $lvs = Filtre_Groupe->new('^\s*LV\s+Name\s+(\S+)$','\s*--- Logical volume ---\s*');
my $pvs = Filtre_Groupe->new('^\s*PV\s+Name\s+(\S+)','\s*--- Physical volumes ---\s*');
my $nom_vg = Filtre_Ligne->new("nom_vg",'VG Name','(\S+)');
my $pv_info = Filtre_Ligne->new("pv_status,pv_uuid,total_pe,free_pe",'PV Status\s+(\S+)|PV UUID\s+(\S+)|Total PE / Free PE\s+(\S+)\s+/\s+(\S+)');
$pv_info->ajout_ligne("pv_name",'PV Name\s+(\S+)');

#filtrage VGS
#$commande->passer_filtre($vgs);
#foreach my $vgn ($vgs->groupe) {
#my @vg = $vgs->groupe($vgn);
#$lvs->filtrer_chaine(@vg);
#foreach my $lvn ($lvs->groupe) {
#my @lv = $lvs->groupe($lvn);
#
#}
#$pvs->filtrer_chaine(@vg);
#$pv_info->filtrer_chaine(@vg);
#foreach my $pvn ($pvs->groupe) {
#foreach my $pvi ($pv_info->groupe) {
#print "$pvi : ",$pv_info->groupe($pvi),"\n";
#
#}
#}
#
#
#}


#$commande->passer_filtre($vgs)->passer_filtre($lvs)->passer_filtre($pvs)->passer_filtre($pv_info)->passer_filtre($nom_vg);
$commande->passer_filtre($nom_vg);

#print "nom du vg : ",$nom_vg->groupe(nom_vg),"\n";
while ($nom_vg->groupe) {
  foreach my $nom ($nom_vg->groupe) {
print $nom_vg->groupe($nom);
}
print "\n";
$nom_vg->suivant;
}

####TEMPO

#while ($pv_info->groupe) {
#foreach my $pvi ($pv_info->groupe) {
#print "$pvi : ",$pv_info->groupe($pvi),"\n";
#}
#print "------\n";
#$pv_info->suivant;
#}


#########
  
#my @vg = $vgs->groupe('rootvg');
#print join("\n",@vg);
#$lvs->utiliser(@vg);
#my @lv = $lvs->groupe('/dev/rootvg/lv_root');
#print "\n",@lv;
#$pvs->utiliser(@vg);
#my @pv = $pvs->groupe('/dev/sdb1');
#$pv_status->utiliser(@pv);
#print "\n",$pv_status->readline->{pv_status};
#print "\n",$pv_status->readline->{pv_status};





#my @gp = $filtre4->groupe($J{valeur});
#print "\ngp\n";
#print @gp;
#print "filtre 5\n";
#my %f5 = %{$filtre5->readline()};
#while ($filtre5->readline()){
#print values %{$filtre5->readline()}
#
#}
