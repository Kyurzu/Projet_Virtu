#!/bin/bash
source ./fonction/Log.sh

#Création de la VM

creationFichierLog()
{
        nom_vm=$1
        creeFichierLog ${nom_vm}
}

#Création de l'image

creationImage()
{
        nom_vm=$1
        taille_disque=$2
        lien=$VM_LIEN_IMAGE
        dateLog $nom_vm
        qemu-img create -f qcow2 -o preallocation=metadata ${lien}${nom_vm}.qcow2 ${taille_disque}G >> system/log_vm/Log_${nom_vm}.log
}

#Création du clone

creationClone()
{
       nom_vm=$1
       lien=$VM_LIEN_IMAGE
       dateLog $nom_vm
       virt-clone --force --original debian8-tpl --name $nom_vm --file ${lien}${nom_vm} >> system/log_vm/Log_${nom_vm}.log
}

#Configuration du nombre de CPU

configuration_cpu()
{
      nom_vm=$1
      nombre_cpu=$2
      dateLog $nom_vm
      virsh start $nom_vm >> system/log_vm/Log_${nom_vm}.log
      dateLog $nom_vm
      virsh setvcpus --count $nombre_cpu $nom_vm --config >> system/log_vm/Log_${nom_vm}.log
}

#Configuration de la RAM
configuration_ram()
{
     nom_vm=$1
     nombre_memoire=$2
     virsh destroy $nom_vm >> system/log_vm/Log_${nom_vm}.log2>&1
     virsh setmaxmem $nom_vm ${nombre_memoire}G --config >> system/log_vm/Log_${nom_vm}.log
}

config_file_log()
{
    nom_vm=$1
    configurationVM_Log ${nom_vm}
}

#Suppression de la VM

suprimerCreationVM ()
{
        nom_vm=$1
        supprimerVM $nom_vm
}

erreurCreationVM ()
{
  code_retour=$1
  if [ ${code_retour} -ne 0 ]
  then
  echo -e "${Red}Erreur detectée verifiez votre saisie${ResetColor}"
  suprimerCreationVM $lire_nom_vm
  sleep 2
  ./page/page_gestion_vm.sh
fi
}

