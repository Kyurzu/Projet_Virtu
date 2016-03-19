#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/Affichage.sh

tete_de_page

listVM_General
echo "Inscrire l'ID de votre VM"

zone_saisie
read choix_id

choix_id=$((choix_id + 2))

nom_vm=`virsh list --all | sed -n ${choix_id}p | awk {'print $2'}`
./page/page_option_vm.sh $nom_vm