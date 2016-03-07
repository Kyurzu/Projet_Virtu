#!/bin/sh

Ajout_cpu_VM()
{

echo Veuillez saisir le nom de la VM
read choix_vm

virsh shutdown $choix_vm

echo Notez le nombre de CPU à ajouter
virsh setvcpus --count $nombre_cpu $nom_vm

echo Changement effectué
virsh domingo $choix_vm | grep cpu

	
}
Ajout_memoire_VM()
{

echo Veuillez saisir le nom de la VM
read choix_vm

virsh shutdown $choix_vm

echo Notez la taille de la nouvelle RAM en KiB
read choix_ram
virsh setmem $choix_vm $choix_ram

echo Changement effectué
virsh dominfo $choix_vm | grep memory
	
}
Ajout_disque_VM()
{

echo Veuillez saisir le nom de la VM
read choix_vm

virsh shutdown $choix_vm

	
}
