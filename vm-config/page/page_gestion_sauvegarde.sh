source ./fonction/Affichage.sh
source ./fonction/SauvegardeVM.sh
nom_vm=$1
tete_de_page
liste_Snapshot $nom_vm
echo "Inscrire l'ID du snapshot"
zone_saisie
read choix_id

choix_id=$((choix_id + 2))

nom_snapshot=`virsh snapshot-list $nom_vm | sed -n ${choix_id}p | awk {'print $1'}`

echo
echo "[1] Creer une snapshot"
echo "[2] Restorer une snapshot"
echo "[3] Supprimer une snapshot"
echo
zone_saisie
read choix_option 

case $choix_option in
1) cree_Snapshot $nom_vm $nom_snapshot 
;;
2) revert_Snapshot $nom_vm $nom_snapshot 
;;
3) suprimer_Snapshot $nom_vm $nom_snapshot
;;
*) echo "Reponse non comprise"
;;
esac
./page/page_gestion_sauvegarde.sh $nom_vm
