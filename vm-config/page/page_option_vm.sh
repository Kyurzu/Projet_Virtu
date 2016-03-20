#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/ChangeEtatVM.sh
source ./fonction/Affichage.sh

zone_saisie

tete_de_page
nom_vm=$1
listVM_Detail $nom_vm

echo
echo

echo "----------------------------------------------------"
echo "           Modification de la VM"
echo
echo "[1] Modifier CPU" 
echo "[2] Modifier RAM" 
echo "[3] Modifier disque"
echo
echo
echo "----------------------------------------------------"
echo "           Changer l'état de la VM"
echo
echo "[4] Demarrer la VM"
echo "[5] Arreter la VM normalement"
echo "[6] Arreter la VM brutalement"
echo "[7] Demarrer automatiquement la VM"
echo "[8] Desactiver le demarrage automatique de la VM"
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
4) etatActif $nom_vm
;;
5) etatArret_douce $nom_vm
;;
6) etatArret_brutal $nom_vm
;;
7) etatAutostart $nom_vm
;;
8) desactiveEtatAutostart $nom_vm
;;
*) echo "réponse non comprise"
;;
esac
