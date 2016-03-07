#!/bin/bash
source ./fonction/ListeVM.sh

listVM_General
echo Entrez le nom de la VM pour voir son détail:
read nom_vm
listVM_Detail $nom_vm
