#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/Affichage.sh

tete_de_page

read nom_vm
listVM_Detail $nom_vm

echo "1. Modifier CPU" 
echo "2. Modifier RAM" 
echo "3. Modifier disque" 
