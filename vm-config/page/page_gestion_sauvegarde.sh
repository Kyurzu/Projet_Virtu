source ./fonction/Affichage.sh
source ./fonction/SauvegardeVM.sh
nom_vm=$1
tete_de_page
liste_Snapshot $nom_vm
echo 
echo "[1] Gestion snapshot de la vm "$nom_vm
echo "[2] Creer une nouvelle snapshot pour la vm "$nom_vm
zone_saisie
read choix_gestion

case $choix_gestion in
	1)
		echo "Inscrire l'ID du snapshot"
		zone_saisie
		read choix_id

		choix_id=$((choix_id + 2))

		nom_snapshot=`virsh snapshot-list $nom_vm | sed -n ${choix_id}p | awk {'print $1'}`

		echo
		echo "[1] Restorer une snapshot"
		echo "[2] Supprimer une snapshot"
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
	echo Ecrire le nom de votre nouvelle snapshot :
	zone_saisie
	read nom_snapshot
	cree_Snapshot $nom_vm $nom_snapshot
	;;
	*) echo "reponse non comprise"
	;;
esac
sleep 3
./page/page_gestion_sauvegarde.sh $nom_vm
