#!/bin/bash

#Entete de page pour chacun de nos scripts
tete_de_page ()
{
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
	clear
	echo -e  "${BlueCyan}        -----------VM CONFIGURATION------------${ResetColor}"
	echo -e  "${BlueCyan}   ___________________________________________________${ResetColor}"
	echo
}

#Affiche une zone de saisie pour le user
zone_saisie ()
{
	echo -n "Saisie :"
}
