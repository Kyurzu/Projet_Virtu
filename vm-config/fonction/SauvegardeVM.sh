#!/bin/bash
source ./fonction/Log.sh

#Permet de creer une Snapshot
cree_Snapshot()
{
	nom_vm=$1
	nom_snapshot=$2

	virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log2>&1
	dateLog $nom_vm
	virsh snapshot-create-as $nom_vm $nom_snapshot " " >> system/log_vm/Log_${nom_vm}.log
}

#Permet de supprimer une Snapshot
suprimer_Snapshot()
{
	nom_vm=$1
	nom_snapshot=$2

	virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log2>&1
	dateLog $nom_vm
	virsh snapshot-delete $nom_vm $nom_snapshot >> system/log_vm/Log_${nom_vm}.log

}

#Permet de supprimer une Snapshot
revert_Snapshot()
{
	nom_vm=$1
	nom_snapshot=$2

	virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log2>&1
	dateLog $nom_vm
	virsh snapshot-revert $nom_vm $nom_snapshot
}

#Liste les Snapshot
liste_Snapshot()
{
	nom_vm=$1

	indice=3
	id_vm=1

	nombreLigne=`virsh snapshot-list $nom_vm | wc -l`
	echo "ID    Nom snapshot              Date de creation          Etat"
	echo "-------------------------------------------------------------------"
	while test $indice != $nombreLigne
	do 
	echo -n -e "\033[31;1;4;5;7m[${id_vm}]\033[0m  "
	virsh snapshot-list $nom_vm | sed -n ${indice}p
	echo "-------------------------------------------------------------------"
	id_vm=$(($id_vm + 1))
	indice=$(($indice + 1))
	done
}
