#!/bin/bash

#Utilise les scripts ci dessous
source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/ChangeEtatVM.sh
source ./fonction/Affichage.sh
source ./fonction/supprimerVM.sh
source ./fonction/Log.sh

nom_vm=$1
code_retour=0
#### Initialisation des variables d'affichage ####

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

#### Fin initialisation variables d'affichage ####
tete_de_page

echo
echo
echo -e "<== \033[31;1;4;5;7m[0]\033[0m Pour revenir dans Gestion des VMs"
echo
echo
echo    "            ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
echo -n "             Option de la vm : " 
Affiche_nom_VM $nom_vm
echo    "            ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
echo
echo -n "Nombre de CPU(s)      : "
Affiche_CPU_VM $nom_vm
echo -n "Etat de la VM         : "
Affiche_state_VM $nom_vm
echo -n "Etat demarage auto    : "
Affiche_autostart $nom_vm
echo -n "Memoire utilisé (Mo)  : "
Affiche_memoire_utiliser $nom_vm
echo -n "Memoire max (Go)      : "
Affiche_memoire_max $nom_vm
echo -n "Memoire Swap          : "
Affiche_memoire_disque $nom_vm
etatVM="$(Affiche_state_VM $nom_vm)"
if [ "${etatVM}" = "running" ]
	then
echo -n "Adresse IP            : "
Affiche_IP $nom_vm
fi

echo
echo
echo -e "\033[31;1;4;5;7m[*]\033[0m Option snapshot VM\c"
echo -e "      \033[31;1;4;5;7m[-]\033[0m Supprimer la VM"

echo    "---------------------------------------------------+"
echo    "           Fichier de log de la VM                 |"
echo    "                                                   |"
echo -e "\033[31;1;4;5;7m[10]\033[0m Consulter les logs                            |"
echo -e "\033[31;1;4;5;7m[20]\033[0m Vider le fichier de log                       |"
echo    "---------------------------------------------------+"
echo    "           Modification de la VM                   |"
echo    "                                                   |"
echo -e "\033[31;1;4;5;7m[1]\033[0m Modifier CPU                                   |"
echo -e "\033[31;1;4;5;7m[2]\033[0m Modifier RAM                                   |"
echo -e "\033[31;1;4;5;7m[3]\033[0m Modifier disque                                |"
echo -e "---------------------------------------------------|"                          
echo    "           Changer l'état de la VM                 |"
echo    "                                                   |"
 

etatVM="$(Affiche_state_VM $nom_vm)"
autosaveVM="$(Affiche_autostart $nom_vm)"

if [ "${etatVM}" = "shut off" ]
then
	if [ $autosaveVM = "disable" ]
	then
		echo -e "\033[31;1;4;5;7m[4]\033[0m Demarrer la VM                                 |"
		echo -e "\033[31;1;4;5;7m[5]\033[0m Demarrer automatiquement la VM                 |"
		combinaisonEtatVM=1
	fi

fi

if [ "${etatVM}" = "shut" ]
then
	if [ $autosaveVM = "enable" ]
        then
		echo -e "\033[31;1;4;5;7m[4]\033[0m Demarrer la VM                                 |"
		echo -e "\033[31;1;4;5;7m[5]\033[0m Desactiver le demarrage automatique de la VM   |"
		combinaisonEtatVM=2
	fi

fi

if [ "${etatVM}" = "running" ]
then
        if [ "${autosaveVM}" = "disable" ]
        then
		echo -e "\033[31;1;4;5;7m[4]\033[0m Arreter la VM (douce)                          |"
		echo -e "\033[31;1;4;5;7m[5]\033[0m Arreter la VM (force)                          |"
		echo -e "\033[31;1;4;5;7m[6]\033[0m Redemarer la VM                                |"

        echo -e "\033[31;1;4;5;7m[7]\033[0m Demarrer automatiquement la VM                 |"
        combinaisonEtatVM=3
        fi
fi

if [ "${etatVM}" = "running" ]
then
        if [ $autosaveVM = "enable" ]
        then
                echo -e "\033[31;1;4;5;7m[4]\033[0m Arreter la VM (douce)                          |"
                echo -e "\033[31;1;4;5;7m[5]\033[0m Arreter la VM (force)                          |"
                echo -e "\033[31;1;4;5;7m[6]\033[0m Redemarer la VM                                |"

                echo -e "\033[31;1;4;5;7m[7]\033[0m Desactiver le demarrage automatique de la VM   |"
                combinaisonEtatVM=4
        fi

fi
echo "---------------------------------------------------+"


zone_saisie
read choix_option

case $choix_option in
1) echo Nombre de CPU
	zone_saisie
   read nombre_cpu
 	modif_cpu_VM $nom_vm $nombre_cpu
 	code_retour=$?
 	echo "${Green}Configuration du nombre de CPU ...${ResetColor}"

;;
2) echo Notez la taille de la nouvelle RAM en Mb
	zone_saisie
   read nombre_ram
 	modif_ram_VM $nom_vm $nombre_ram
 	 	code_retour=$?
 	echo "${Green}Configuration de la RAM ...${ResetColor}"
;;
3) echo "Veuillez saisir le nom du disque à ajouter"
   zone_saisie
   read nom_disk
   echo "Veuillez saisir la taille du disque en Mb"
   zone_saisie
   read taille_disk
   modif_disque_VM $nom_vm $nom_disk $taille_disk
      code_retour=$?
   echo "${Green}Configuration de la memoire disque ...${ResetColor}"
;;
esac

if [ $combinaisonEtatVM -eq 1 ]
then
	case $choix_option in
	4) etatActif $nom_vm
		code_retour=$?
		echo "${Green}Demarage de la VM ...${ResetColor}"
	;;
	5) etatAutostart $nom_vm
		code_retour=$?
		echo "${Green}Activation de la VM en mode autodémarage ...${ResetColor}"
	;;
esac


elif [ $combinaisonEtatVM -eq 2 ]
then
	case $choix_option in
	4) etatActif $nom_vm
		code_retour=$?
		echo "${Green}Demarage de la VM ...${ResetColor}"
	;;
	5) desactiveEtatAutostart $nom_vm
		code_retour=$?
		echo "${Green}Désactivation de la VM en mode autodémarage ...${ResetColor}"
	;;
esac

elif [ $combinaisonEtatVM -eq 3 ]
then
	case $choix_option in
	4) etatArret_douce $nom_vm
		code_retour=$?
	echo "${Green}Arret de la VM ...${ResetColor}"
	;;
	5) etatArret_brutal $nom_vm
		code_retour=$?
		echo "${Green}Arret de la VM ...${ResetColor}"
	;;
	6) etatReboot $nom_vm 
		code_retour=$?
		echo "${Green}Redémarage de la VM ...${ResetColor}"
	;;
	7) etatAutostart $nom_vm
		code_retour=$?
		echo "${Green}Activation de la VM en mode autodémarage ...${ResetColor}"
	;;
esac

elif [ $combinaisonEtatVM -eq 4 ]
then
	case $choix_option in
	4) etatArret_douce $nom_vm
		code_retour=$?
		echo "${Green}Arret de la VM ...${ResetColor}"
	;;
	5) etatArret_brutal $nom_vm
		code_retour=$?
		echo "${Green}Arret de la VM ...${ResetColor}"
	;;
	6) etatReboot $nom_vm
		code_retour=$?
		echo "${Green}Redémarage de la VM ...${ResetColor}"
	;;
	7) desactiveEtatAutostart $nom_vm
		code_retour=$?
		echo "${Green}Désactivation de la VM en mode autodémarage ...${ResetColor}"
	;;
esac
fi

case $choix_option in
0) ./page/page_gestion_vm.sh
	exit 0
;;
1)
;;
2)
;;
3)
;;
4)
;;
5)
;;
6)
;;
7)
;;
"*") ./page/page_gestion_sauvegarde.sh $nom_vm
;;
"-") echo "Etes vous sur de vouloir supprimer cette vm ?"
	echo -e "\033[31;1;4;5;7m[1]\033[0m OUI"
	echo -e "\033[31;1;4;5;7m[2]\033[0m NON"
	zone_saisie
	read confirmationSuppr
	if [ $confirmationSuppr -eq 1 ]
		then
        supprimerVM $nom_vm
        code_retour=$?
        sleep 1
		./page/page_gestion_vm.sh
		fi
;;
10) less system/log_vm/Log_${nom_vm}.log
;;
20) creeFichierLog ${nom_vm}
;;
*) echo "Reponse non comprise"
	code_retour=-1
;;
esac
	if [ ${code_retour} -ne 0 ]
		then
		echo "${Red}Erreur detectée verifiez votre saisie, voir system/log_vm/${nom_vm}.log${ResetColor}"
		sleep 3
		./page/page_option_vm.sh $nom_vm
	else
		echo
 		echo "${Green}     ****  Changement effectue  ****${ResetColor}"
    fi
echo -e "Appuyez sur la touche <Entrée> pour continuer ...\c"
read touche
case $touche in
*) ./page/page_option_vm.sh $nom_vm
	;;
esac
