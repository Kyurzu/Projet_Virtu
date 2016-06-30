#!/bin/bash
source ./system/lien.txt

#Arret de la machine modele
virsh shutdown $VM_TEMPLATE

#Appel du script page_gestion_vm.sh
./page/page_gestion_vm.sh
