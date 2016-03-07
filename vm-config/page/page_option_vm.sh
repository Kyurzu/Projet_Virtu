#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/Affichage.sh

echo Nom de la vm
read nom_vm
zone_saisie

tete_de_page
listVM_Detail $nom_vm

echo
echo

echo "-------------------------------"
echo "           Option"

echo "1. Modifier CPU" 
echo "2. Modifier RAM" 
echo "3. Modifier disque"
zone_saisie
