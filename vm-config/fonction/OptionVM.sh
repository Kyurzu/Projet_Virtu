#!/bin/bash
modif_cpu_VM()
{
 nom_vm=$1
 nombre_cpu=$2
 virsh start $nom_vm

 virsh setvcpus --count $nom_vm $nombre_cpu --config
 virsh shutdown $nom_vm
	
}
modif_ram_VM()
{
 
 nom_vm=$1
 nombre_memoire=$2

virsh start $nom_vm
virsh setmem $nom_vm ${nombre_memoire}M --config
virsh shutdown $nom_vm	
}
modif_disque_VM()
{

echo Veuillez saisir le nom de la VM
read choix_vm

virsh shutdown $choix_vm

}
