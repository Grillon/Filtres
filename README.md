Les Filtres
===========

Description des filtres :

Un filtre est une maniere de traiter un ensemble de caracteres. Ces caracteres doivent provenir d une liste. Ce qui est pratique dans la mesure ou l entree standard et un fichier sont transforme en liste par le while en perl.

j'ai cree 2 types de filtres :

* filtres de modifications tel que

** inclusions/exclusions

  Il inclut les lignes contenant un element de la liste d inclusion puis en exclus les lignes contenant un terme de la liste d exclusion.
    -exemple : vgdisplay -v / incusion : VG Name,VG S / exclusion : VG Status
    l Inclusion prendra ceci :
    VG Name               vg00
    VG Status             resizable
    VG Size               450,77 GiB
    apres l exclusion il restera ceci :
    VG Name               vg00
    VG Size               450,77 GiB

* filtres de groupement tel que

* groupement
  Il groupe les elements entre deux marqueurs. Si le deuxieme marqueur n est pas indiqué alors le premier marqueur sera egalement consideré marqueur de fin.
    -exemple : vgdisplay -v / debut : "--- Volume group ---", fin : "", titre : "VG Name%s(.*)"
    le groupe contiendra la totalite des infos d un vg et chaque groupe portera le nom du vg.

* structure de groupe
  Il structure les elements d'un groupe. Dans l'ideal je souhaiterais qu il deduise la structure d un groupe a partir des repetitions. Cela ne semble pas trop difficile mais bon je suis peut etre un peu trop presomptueux. Je ne suis qu un petit padawan apres tout.
  Pour arriver a structurer un groupe il faut definir la structure du groupe et que le groupe soit deja forme.
  -exemple avec le groupe precedent : soit la liste suivante 1) "nom_vg" : "VG Name%s(.*)" / 2) "taille_vg" : "VG Size%s(.*) [M,G]iB" / etc...
   cela structurera le groupe en une liste de nom/valeur.

  -exemple2 avec ls -l : soit la liste suivante 1) "droit","nbr_lien","utilisateur","groupe","taille","date","nom_fichier" : "(.*)%s([0-9]+)%s(.*)%s(.*)%s([0-9]+)%s([0-9]+%s[[:alpha:]]+%s[0-9]+:[0-9]+)%s(.*)" /  
   dans cet exemple il n y a qu un element dans la liste mais il est compose de plusieurs colonne.

   Ce filtre est le plus difficile a construire. Je n ai pas encore trouve le moyen de transmettre ces structures...Peut via un tableau a deux dimensions...ou un hash de hash ...
   un objet groupe?


   NB : la syntaxe de l expression reguliere est fausse mais c est pour donner une idee. Je ne suis pas d'humeur a chercher les details maintenant.

Filtres - une bibliotheque de filtres a base d'expressions regulieres
Copyright (C) 2014-2015  Thierry VOGEL

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
