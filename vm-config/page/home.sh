#!/bin/bash
source ./fonction/Affichage.sh
tete_de_page
#echo "VM CONFIG"
echo "[1] Gestion VM"
echo "[2] Ajouter une VM"
zone_saisie
read lire_choix

case $lire_choix in
1) ./page/page_gestion_vm.sh
;;
2) ./page/page_creationVM.sh
;;
*) echo "Réponse non comprise"
;;
esac
