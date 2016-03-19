#!/bin/sh

listVM_General()
{
nombreLigne=`virsh list --all | wc -l`

indice=3
id_vm=1
echo "ID             Name                           State"
echo "-------------------------------------------------------------------"
while test $indice != $nombreLigne
do 
	echo -n [${id_vm}]   ----
	virsh list --all | sed -n ${indice}p
	echo
	id_vm=$(($id_vm + 1))
	indice=$(($indice + 1))
done

}
listVM_Detail()
{
nom_vm=$1
virsh dominfo $nom_vm | grep '\(Name\|State\|CPU\|\Max memory\|Used memory\|Autostart\)'
}

Affiche_nom_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Nom
}

Affiche_CPU_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep CPU
}

Affiche_state_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep État
}
Affiche_memoire_utiliser()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Mémoire utilisée
}
Affiche_memoire_max()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Mémoire Max
}
Affiche_autostart()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Démarrage automatique
}
Affiche_memoire_disque()
{
nom_vm=$1
}
