#!/bin/sh

cree_Snapshot()
{
	nom_vm=$1
	nom_snapshot=$2

	virsh destroy $nom_vm
	virsh snapshot-create-as $nom_vm $om_snapshot " "
}

suprimer_Snapshot()
{
	nom_vm=$1
	nom_snapshot=$2

	virsh destroy $nom_vm
	virsh snapshot-delete $nom_vm $nom_snapshot

}

revert_Snapshot()
{
	nom_vm=$1
	nom_snapshot=$2

	virsh destroy $nom_vm
	virsh snapshot-revert $nom_vm $nom_snapshot
}

liste_Snapshot()
{
	nom_vm=$1

	indice=3
	id_vm=1

	nombreLigne=`virsh snapshot-list $nom_vm | wc -l`
	echo "ID       Nom snapshot      Date de creation            Etat"
	echo "-------------------------------------------------------------------"
	while test $indice != $nombreLigne
	do 
	echo -n [${id_vm}]   ----
	virsh snapshot-list $nom_vm | sed -n ${indice}p
	echo
	id_vm=$(($id_vm + 1))
	indice=$(($indice + 1))
	done
}
