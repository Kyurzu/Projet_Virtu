#!/bin/bash
CreationVM()
{
	nom_vm=$1
	nombre_cpu=$2
	nombre_memoire=$3
	taille_disque=$4

	lien=`sed -n 1p system/lien.txt`
	
	qemu-img create -f qcow2 -o preallocation=metadata  ${lien}${nom_vm}.qcow2 ${taille_disque}M
	echo -->disque dur virtuelle créer
	virt-clone --force --original debian8-tpl --name $nom_vm --file /var/img/img-original/$nom_vm'.debian'
	echo "vm allumer"
	virsh start $nom_vm
	echo "debut sleep"
	sleep 5
	echo "setmen"
	virsh setmem $nom_vm $nombre_memoire
	echo "cpu"
	virsh setvcpus --count $nombre_cpu $nom_vm
	echo "supression vm"
	virsh destroy $nom_vm
}
