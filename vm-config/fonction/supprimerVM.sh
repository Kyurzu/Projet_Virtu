#!/bin/sh

supprimerVM()
{
 lien=`sed -n 1p system/lien.txt`
 nom_vm=$1
 virsh destroy $nom_vm
 virsh undefine $nom_vm
 rm ${lien}${nom_vm}
 rm ${lien}${nom_vm}.qcow2
}

