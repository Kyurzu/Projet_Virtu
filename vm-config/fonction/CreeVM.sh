#!/bin/bash
CreationVM()
{
	nom_vm=$1
	nombre_cpu=$2
	nombre_memoire=$3
	taille_disque=$4
	
	qemu-img create ../../projet/img/$nom_vm.debian  ${taille_disque}M >/var/null
	echo -->disque dur virtuelle créer
	virt-clone --force --original debian --name $nom_vm --file /home/mebou/Documents/OSS/projet/img/$nom_vm.debian
	virsh destroy $nom_vm
	virsh setvcpus --count $nombre_cpu $nom_vm
}
