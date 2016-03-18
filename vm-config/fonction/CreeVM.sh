#!/bin/bash
CreationVM()
{
	nom_vm=$1
	nombre_cpu=$2
	nombre_memoire=$3
	taille_disque=$4
	
	qemu-img create -f qcow2 -o preallocation=metadata  /var/lib/libvirt/images/${nom_vm}.qcow2 ${taille_disque}M
	echo -->disque dur virtuelle créer
	virt-clone --force --original debian8-tpl --name $nom_vm --file /var/img/img-original/$nom_vm'.debian'
	virsh destroy $nom_vm
	virsh setvcpus --count $nombre_cpu $nom_vm
}
