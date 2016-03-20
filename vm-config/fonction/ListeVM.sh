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

Affiche_nom_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Name | awk {'print $2'}
}

Affiche_CPU_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep CPU | awk {'print $2'}
}

Affiche_state_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep State | awk {'print $2,$3'}
}
Affiche_memoire_utiliser()
{
nom_vm=$1
virsh dominfo $nom_vm | grep "Used memory" | awk {'print $3'}
}
Affiche_memoire_max()
{
nom_vm=$1
virsh dominfo $nom_vm | grep "Max memory" | awk {'print $3'}
}
Affiche_autostart()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Autostart | awk {'print $2'}
}
Affiche_memoire_disque()
{
nom_vm=$1
}
sauvegarder_Liste()
{
	nom_vm=$1
	virsh dominfo $nom_vm | grep Name | awk {'print $2'} > system/lien.txt
	virsh dominfo $nom_vm | grep CPU | awk {'print $2'} >> system/lien.txt
	virsh dominfo $nom_vm | grep State | awk {'print $2,$3'} >> system/lien.txt
	virsh dominfo $nom_vm | grep "Used memory" | awk {'print $3'} >> system/lien.txt
	virsh dominfo $nom_vm | grep "Max memory" | awk {'print $3'} >> system/lien.txt
	virsh dominfo $nom_vm | grep Autostart | awk {'print $2'} >> system/lien.txt

}
