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
 lien=`sed -n 1p system/lien.txt`
 nom_vm=$1
 nom_disk=$2
 taille_disque=$3

 virsh destroy $nom_vm
 qemu-img create -f qcow2 ${lien}${nom_disk}.qcow2 ${taille_disque}M
 virsh attach-disk $nom_vm /var/lib/libvirt/images/${nom_disk}.qcow2 --target vdb --persistent

}
