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
echo Veuillez saisir également le nom du disque à ajouter
read choix_disk

virsh destroy $choix_vm
cd /var/lib/libvirt/images/
qemu-img create -f raw ${choix_disk}.img 1G
virsh attach-disk $choix_vm --source /var/lib/libvirt/images/${choix_disk}.img --target vdb --persistent

}
