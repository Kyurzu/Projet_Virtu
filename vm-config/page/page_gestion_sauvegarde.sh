#!/bin/bash

#Utilise les scripts ci dessous

source ./fonction/Affichage.sh
source ./fonction/SauvegardeVM.sh
nom_vm=$1
tete_de_page
echo
echo -e "<== \033[31;1;4;5;7m[0]\033[0m Pour revenir dans options de la VM "$nom_vm
echo
echo
echo
liste_Snapshot $nom_vm
echo 
echo -e "\033[31;1;4;5;7m[1]\033[0m Gestion snapshot de la vm "$nom_vm
echo -e "\033[31;1;4;5;7m[2]\033[0m Creer une nouvelle snapshot pour la vm "$nom_vm
zone_saisie
read choix_gestion

#Créé un menu pour que l'utilisitateur utilise le script de manière intuitif
case $choix_gestion in
	0)  
	   ./page/page_option_vm.sh $nom_vm 
	   exit 0
    ;;
	1)
		echo "Inscrire l'ID du snapshot"
		zone_saisie
		read choix_id

		choix_id=$((choix_id + 2))

		nom_snapshot=`virsh snapshot-list $nom_vm | sed -n ${choix_id}p | awk {'print $1'}`

		echo
		echo -e "\033[31;1;4;5;7m[1]\033[0m Restorer une snapshot"
		echo -e "\033[31;1;4;5;7m[2]\033[0m Supprimer une snapshot"
		echo
		zone_saisie
		read choix_option 

		case $choix_option in
		1) revert_Snapshot $nom_vm $nom_snapshot  
		;;
		2) suprimer_Snapshot $nom_vm $nom_snapshot 
		;;
		*) echo "Reponse non comprise"
		;;
		esac
	;;
	2)
	echo "Ecrivez le nom de votre nouvelle snapshot :"
	zone_saisie
	read nom_snapshot
	cree_Snapshot $nom_vm $nom_snapshot
	;;
	*) echo "reponse non comprise"
	;;
esac
sleep 1
./page/page_gestion_sauvegarde.sh $nom_vm
