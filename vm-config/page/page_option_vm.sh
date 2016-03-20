#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/OptionVM.sh
source ./fonction/ChangeEtatVM.sh
source ./fonction/Affichage.sh

zone_saisie

tete_de_page
nom_vm=$1
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


echo
echo

echo "---------------------------------------------------+"
echo "           Modification de la VM                   |"
echo "                                                   |"
echo "[1] Modifier CPU                                   |" 
echo "[2] Modifier RAM                                   |" 
echo "[3] Modifier disque                                |                         [9] Option snapshot VM"
echo "----------------------------------------------------                         [10] Option supression VM"                          
echo "           Changer l'état de la VM                 |"
echo "                                                   |"
#echo "[4] Demarrer la VM                                 |"
#echo "[5] Arreter la VM normalement                      |"
#echo "[6] Arreter la VM brutalement                      |"
#echo "[7] Demarrer automatiquement la VM                 |"
#echo "[8] Desactiver le demarrage automatique de la VM   |"


sauvegarder_Liste $nom_vm 

etatVM=`sed -n 3p system/SaveList.txt`
autosaveVM=`sed -n 6p system/SaveList.txt`

if [ "${etatVM}" = "shut" ]
then
	if [ $autosaveVM = "disable" ]
	then
		echo "[4] Demarrer la VM                                 |"
		echo "[5] Demarrer automatiquement la VM                 |"
		combinaisonEtatVM=1
	fi

fi

if [ "${etatVM}" = "shut" ]
then
	if [ $autosaveVM = "enable" ]
        then
		echo "[4] Demarrer la VM                                 |"
		echo "[5] Desactiver le demarrage automatique de la VM   |"
		combinaisonEtatVM=2
	fi

fi

if [ "${etatVM}" = "running" ]
then
        if [ "${autosaveVM}" = "disable" ]
        then
		echo "[4] Arreter la VM (douce)                          |"
		echo "[5] Arreter la VM (force)                          |"
		echo "[6] Redemarer la VM                                |"

        echo "[7] Demarrer automatiquement la VM                 |"
        combinaisonEtatVM=3
        fi
fi

if [ "${etatVM}" = "running" ]
then
        if [ $autosaveVM = "enable" ]
        then
                echo "[4] Arreter la VM normalement                      |"
                echo "[5] Arreter la VM brutalement                      |"
                echo "[6] Redemarer la VM                                |"

                echo "[7] Desactiver le demarrage automatique de la VM   |"
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
*) echo "réponse non comprise"
;;
esac

if [ $combinaisonEtatVM eq 1 ]
then
	case $choix_option in
	4) etatActif $nom_vm
	;;
	5) etatAutostart $nom_vm
	;;
	*) echo "réponse non comprise"
	;;
esac


elif [ $combinaisonEtatVM eq 2 ]
then
	case $choix_option in
	4) etatActif $nom_vm
	;;
	5) desactiveEtatAutostart $nom_vm
	;;
	*) echo "réponse non comprise"
	;;
esac

elif [ $combinaisonEtatVM eq 3 ]
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
	*) echo "réponse non comprise"
	;;
esac

elif [ $combinaisonEtatVM eq 4 ]
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
	*) echo "réponse non comprise"
	;;
esac

fi

./page/page_option_vm.sh $nom_vm
