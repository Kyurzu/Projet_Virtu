#!/bin/bash
modif_cpu_VM()
{
 nom_vm=$1
 nombre_cpu=$2
 virsh start $nom_vm

 virsh setvcpus --count $nombre_cpu $nom_vm --config
 virsh destroy $nom_vm
	
}
modif_ram_VM()
{
 
 nom_vm=$1
 nombre_memoire=$2
virsh destroy $nom_vm
virsh setmaxmem $nom_vm ${nombre_memoire}M --config
}
modif_disque_VM()
{

echo Veuillez saisir le nom de la VM
read choix_vm

virsh shutdown $choix_vm

}
