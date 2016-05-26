#!/bin/bash
source ./fonction/Log.sh

#Permet de modifier le nombre de CPU de la VM
modif_cpu_VM()
{
 nom_vm=$1
 nombre_cpu=$2
 virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log 2>&1
 dateLog $nom_vm
 virsh setvcpus --count $nombre_cpu $nom_vm --config
 echo Le nombre de CPU est passé à : ${nombre_cpu} >> system/log_vm/Log_${nom_vm}.log
}

#Permet de modifier la RAM max de la VM
modif_ram_VM()
{
 
 nom_vm=$1
 nombre_memoire=$2
 virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log 2>&1
 dateLog $nom_vm
 virsh setmaxmem $nom_vm ${nombre_memoire}M --config
 echo Le nombre de RAM est passé à : ${nombre_memoire}M  >> system/log_vm/Log_${nom_vm}.log
}

#Permet de modifier le nombre de disque de la VM
modif_disque_VM()
{
 lien=`sed -n 1p system/lien.txt`
 nom_vm=$1
 nom_disk=$2
 taille_disque=$3

 virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log 2>&1
 qemu-img create -f qcow2 ${lien}${nom_disk}.qcow2 ${taille_disque}M 
 echo Le disque ${nom_disk} a été créé >> system/log_vm/Log_${nom_vm}.log
 dateLog $nom_vm
 virsh attach-disk $nom_vm /var/lib/libvirt/images/${nom_disk}.qcow2 --target vdb --persistent 
 echo Le disque ${nom_disk} a été attaché >> system/log_vm/Log_${nom_vm}.log
}
