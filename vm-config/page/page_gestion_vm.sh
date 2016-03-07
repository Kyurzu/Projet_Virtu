#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/Affichage.sh

tete_de_page

listVM_General
./page/page_option_vm.sh
echo "1. detail de la vm"
echo "2. creer une snapshot"

zone_saisie
read choix_option

case $choix_option in
1) ./page/page_option_vm.sh
;;
2) ./page/page_creationVM.sh
;;
*) echo "réponse non comprise"
;;
esac
