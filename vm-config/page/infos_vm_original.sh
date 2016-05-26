#!/bin/bash


#Utilise les scripts ci dessous

source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/ChangeEtatVM.sh
source ./fonction/Affichage.sh
source ./fonction/supprimerVM.sh

nom_vm=$1

tete_de_page


#Affiche l'interface de l'utilisateur

echo
echo    "            ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
echo -n "             Nom de la vm d'origine : " 
Affiche_nom_VM $nom_vm
echo    "            ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
echo
echo -n "Nombre de CPU(s)      : "
Affiche_CPU_VM $nom_vm
echo -n "Etat de la VM         : "
Affiche_state_VM $nom_vm
echo -n "Etat demarage auto    : "
Affiche_autostart $nom_vm
echo -n "Memoire utilisé (Kib) : "
Affiche_memoire_utiliser $nom_vm
echo -n "Memoire max (Kib)     : "
Affiche_memoire_max $nom_vm
etatVM=`sed -n 3p system/SaveList.txt`
echo

echo -e "Appuyez sur la touche <Entrée> pour revenir dans Gestion des VMs ...\c"
read touche
case $touche in
*) ./page/page_gestion_vm.sh
	;;
esac
