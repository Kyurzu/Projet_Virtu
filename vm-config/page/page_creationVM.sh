#!/bin/bash

#Utilise les scripts ci dessous
source ./fonction/CreeVM.sh
source ./fonction/infoServeur.sh
source ./fonction/Affichage.sh

#### Initialisation des variables ####

#+ Mode normal
ResetColor="$(tput sgr0)"
# "Surligné" (bold)
bold=$(tput smso)
# "Non-Surligné" (offbold)
offbold=$(tput rmso)

# Couleurs (gras)
#+ Rouge
Red="$(tput bold ; tput setaf 1)"
#+ Vert
Green="$(tput bold ; tput setaf 2)"
#+ Jaune
Yellow="$(tput bold ; tput setaf 3)"
#+ Bleue
Blue="$(tput bold ; tput setaf 4)"
#+ Cyan
BlueCyan="$(tput bold ; tput setaf 6)"

#### Fin initialisation variables ####

tete_de_page
echo 
echo "          ${Green}${bold}Gestionnaire de création d'une VM${offbold}${ResetColor}"
echo
echo 
echo "               ---Info du serveur--- "
echo "------------------------------------------------------------"
echo "CPU"
echo -n "Nombre de CPU :"
nb_cpu_serveur
echo -n "Model de CPU  :"
nom_cpu_serveur
echo 
echo "------------------------------------------------------------"
echo
echo -n "Espace disque disponible :"
nbr_espace_disque_serveur
echo
echo "------------------------------------------------------------"
echo "RAM"
echo -n "Memoire ram total (Go)   :"
nbr_ram_total
echo -n "Memoire ram utilise (GO) :"
nbr_ram_utilise
echo -n "Memoire ram libre (GO)   :"
nbr_ram_libre
echo 
echo "------------------------------------------------------------"
echo 


# Pré-affichage des champs
tput cup 28 1
echo -e "${Blue}Nom de votre nouvelle vm :${ResetColor}[                  ]"

tput cup 30 1
echo -e "${Blue}Nombre de CPU            :${ResetColor}[                  ]"

tput cup 32 1
echo -e "${Blue}Mémoire (Go)             :${ResetColor}[               Go ]"

tput cup 34 1
echo -e "${Blue}Taille disque (Go)       :${ResetColor}[               Go ]"


tput cup 28 1
echo -e "${Blue}Nom de votre nouvelle vm :${ResetColor}[\c "
read lire_nom_vm
tput cup 30 1
echo -e "${Blue}Nombre de CPU            :${ResetColor}[\c "
read lire_nombre_cpu

nombre_vm_maxi=`virsh dumpxml debian8-tpl | grep "vcpu" | cut -c40`

if [ ! "$(echo ${lire_nombre_cpu} | grep "^[ [:digit:] ]*$")" ]
	then
	tput cup 30 48
	echo -e "${Red}<== Entrez un nombre entier${ResetColor} Appuyez sur la touche <Entrée>"
	read touche
	case $touche in
	*) ./page/page_creationVM.sh
	;;
	esac
elif [ ${lire_nombre_cpu} -gt ${nombre_vm_maxi} ]
		then
		tput cup 30 48
		echo -e "${Red}<== Le nombres de cpu doit etre inferieure ou égale à ${nombre_vm_maxi}${ResetColor} Appuyez sur la touche <Entrée>"
	read touche
	case $touche in
	*) ./page/page_creationVM.sh
	;;
	esac
	fi
tput cup 32 1
echo -e "${Blue}Mémoire (Go)             :${ResetColor}[\c "
read lire_nombre_memoire

nbr_max_memoireRAM=`free -g | grep "Mem:" | awk {'print $4'}`
nbr_max_memoireRAM=$((nbr_max_memoireRAM - 3))

if [ ! "$(echo ${lire_nombre_memoire} | grep "^[ [:digit:] ]*$")" ]
	then
	tput cup 32 48
	echo -e "${Red}<== Entrez un nombre entier${ResetColor} Appuyez sur la touche <Entrée>"
	read touche
	case $touche in
	*) ./page/page_creationVM.sh
	;;
	esac
elif [ ${lire_nombre_memoire} -gt ${nbr_max_memoireRAM} ]
		then
		tput cup 32 48
		echo -e "${Red}<== Le nombres de Go de RAM doit etre inferieure ou égale à ${nbr_max_memoireRAM}${ResetColor} Appuyez sur la touche <Entrée>"
	read touche
	case $touche in
	*) ./page/page_creationVM.sh
	;;
	esac
fi


tput cup 34 1
echo -e "${Blue}Taille disque (Go)       :${ResetColor}[\c "
read  lire_taille_disque
if [ ! "$(echo ${lire_taille_disque} | grep "^[ [:digit:] ]*$")" ]
	then
	tput cup 32 48
	echo -e "${Red}<== Entrez un nombre entier${ResetColor} Appuyez sur la touche <Entrée>"
	read touche
	case $touche in
	*) ./page/page_creationVM.sh
	;;
	esac
elif [ ${lire_taille_disque} -gt 300 ]
	then
	tput cup 32 48
	echo -e "${Red}<== Le nombres de Go de memoire disque doit etre inferieure ou égale à 300${ResetColor} Appuyez sur la touche <Entrée>"
	read touche
	case $touche in
	*) ./page/page_creationVM.sh
	;;
	esac
fi
echo
echo "---------------------------------------------------------------"
echo
creationFichierLog $lire_nom_vm
echo -e "Etape 1 : ${Green}Creation de l'image de la vm...${ResetColor}"
creationImage $lire_nom_vm $lire_taille_disque

erreurCreationVM $? $lire_nom_vm

echo
echo -e "Etape 2 : ${Green}Creation du clone de la vm d'origine...${ResetColor}"
creationClone $lire_nom_vm

erreurCreationVM $? $lire_nom_vm

echo
echo -e "Etape 3 : ${Green}Configuration du nombres de CPU...${ResetColor}"
configuration_cpu $lire_nom_vm $lire_nombre_cpu

erreurCreationVM $? $lire_nom_vm

echo
echo -e "Etape 4 : ${Green}Configuration du nombres de RAM...${ResetColor}"
configuration_ram $lire_nom_vm $lire_nombre_memoire

erreurCreationVM $? $lire_nom_vm

echo
echo -e "${Green}         *****  VM créée avec succes  *****${ResetColor}"
config_file_log $lire_nom_vm

echo -e "Appuyez sur la touche <Entrée> pour continuer ...\c"
read touche
case $touche in
*) ./page/page_gestion_vm.sh
	;;
esac