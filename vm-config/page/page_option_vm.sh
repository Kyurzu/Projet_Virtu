#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/ChangeEtatVM.sh
source ./fonction/Affichage.sh
source ./fonction/supprimerVM.sh

zone_saisie

tete_de_page

nom_vm=$1
echo
echo
echo -e "<== \033[31;1;4;5;7m[0]\033[0m Pour revenir dans Gestion des VMs"
echo
echo
echo    "            ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
echo -n "             Nom de la vm : " 
Affiche_nom_VM $nom_vm
echo    "            ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬"
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
echo -n "Memoire soap          : "
Affiche_memoire_disque $nom_vm
echo -n "Adresse IP            : "
Affiche_IP $nom_vm


echo
echo
echo -e "\033[31;1;4;5;7m[10]\033[0m Option snapshot VM"
echo -e "\033[31;1;4;5;7m[20]\033[0m Supprimer la VM"

echo    "---------------------------------------------------+"
echo    "           Modification de la VM                   |"
echo    "                                                   |"
echo -e "\033[31;1;4;5;7m[1]\033[0m Modifier CPU                                   |"
echo -e "\033[31;1;4;5;7m[2]\033[0m Modifier RAM                                   |"
echo -e "\033[31;1;4;5;7m[3]\033[0m Modifier disque                                |"
echo -e "---------------------------------------------------|"                          
echo    "           Changer l'état de la VM                 |"
echo    "                                                   |"


sauvegarder_Liste $nom_vm 

etatVM=`sed -n 3p system/SaveList.txt`
autosaveVM=`sed -n 6p system/SaveList.txt`

if [ "${etatVM}" = "shut" ]
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
 	echo Changement effectue
;;
2) echo Notez la taille de la nouvelle RAM en Mb
	zone_saisie
   read nombre_ram
 	modif_ram_VM $nom_vm $nombre_ram
 	echo Changement effectue
;;
3) echo "Veuillez saisir le nom du disque à ajouter"
   zone_saisie
   read nom_disk
   echo "Veuillez saisir la taille du disque"
   zone_saisie
   read taille_disk
   modif_disque_VM $nom_vm $nom_disk $taille_disk
;;
esac

if [ $combinaisonEtatVM -eq 1 ]
then
	case $choix_option in
	4) etatActif $nom_vm
	;;
	5) etatAutostart $nom_vm
	;;
esac


elif [ $combinaisonEtatVM -eq 2 ]
then
	case $choix_option in
	4) etatActif $nom_vm
	;;
	5) desactiveEtatAutostart $nom_vm
	;;
esac

elif [ $combinaisonEtatVM -eq 3 ]
then
	case $choix_option in
	4) etatArret_douce $nom_vm
	;;
	5) etatArret_brutal $nom_vm
	;;
	6) etatReboot $nom_vm 
	;;
	7) etatAutostart $nom_vm
	;;
esac

elif [ $combinaisonEtatVM -eq 4 ]
then
	case $choix_option in
	4) etatArret_douce $nom_vm
	;;
	5) etatArret_brutal $nom_vm
	;;
	6) etatReboot $nom_vm 
	;;
	7) desactiveEtatAutostart $nom_vm
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
10) ./page/page_gestion_sauvegarde.sh $nom_vm
;;
20) echo "Etes vous sur de vouloir supprimer cette vm ?"
	echo -e "\033[31;1;4;5;7m[1]\033[0m OUI"
	echo -e "\033[31;1;4;5;7m[2]\033[0m NON"
	zone_saisie
	read confirmationSuppr
	if [ $confirmationSuppr -eq 1 ]
		then
        supprimerVM $nom_vm
        sleep 3
		./page/page_gestion_vm.sh
		fi
;;
*) echo "Reponse non comprise"
;;
esac
sleep 3
./page/page_option_vm.sh $nom_vm
