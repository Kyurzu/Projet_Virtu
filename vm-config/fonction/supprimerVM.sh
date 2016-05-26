#!/bin/sh
source ./fonction/Log.sh
#Permet de supprimer une VM
supprimerVM()
{
 lien=`sed -n 1p system/lien.txt`
 nom_vm=$1
 virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log 2>&1
 virsh undefine $nom_vm >> system/log_vm/Log_${nom_vm}.log 2>&1
 rm ${lien}${nom_vm} 
 rm ${lien}${nom_vm}.qcow2
 suprimmerLog $nom_vm
}
