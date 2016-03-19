#!/bin/sh

modif_cpu_VM()
{
 nom_vm=$1
 nombre_cpu=$2
 virsh start $nom_vm

 virsh setvcpus --count $nombre_cpu $nom_vm
 virsh destroy $nom_vm
	
}
modif_ram_VM()
{

 nom_vm=$1
 nombre_ram=$2

virsh destroy $nom_vm
virsh setmem $nom_vm $nombre_ram
	
}
modif_disque_VM()
{

echo Veuillez saisir le nom de la VM
read choix_vm

virsh shutdown $choix_vm

	
}
