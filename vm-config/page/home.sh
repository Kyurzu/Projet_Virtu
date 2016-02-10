#!/bin/bash
source ./fonction/Affichage.sh
tete_de_page
#echo "VM CONFIG"
echo "1 : Gestion VM"
echo "2 : Ajouter une VM"
zone_saisie
read lire_choix

case $lire_choix in
1) echo "à faire"
;;
2) ./page/page_creationVM.sh
;;
*) echo "réponse non comprise"
;;
esac
