#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/Affichage.sh

zone_saisie

tete_de_page
nom_vm=$1
listVM_Detail $nom_vm

echo
echo

echo "-------------------------------"
echo "           Option"

echo "1. Modifier CPU" 
echo "2. Modifier RAM" 
echo "3. Modifier disque"
read choix_option
zone_saisie

case $choix_option in
1) echo Nombre de CPU
	zone_saisie
   read nombre_cpu
 	modif_cpu_VM $nom_vm $nombre_cpu
 	echo Changement effectue
;;
2) echo Notez la taille de la nouvelle RAM en Mb
	zone_saisie
   read nombre_ram
 	modif_ram_VM $nom_vm $nombre_ram
 	echo Changement effectue
;;
3) modif_disque_VM $nom_vm
;;
*) echo "réponse non comprise"
;;
esac
