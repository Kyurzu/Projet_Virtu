#!/bin/bash

#Arret de la machine modele
virsh shutdown debian8-tpl

#Appel du script page_gestion_vm.sh
./page/page_gestion_vm.sh
