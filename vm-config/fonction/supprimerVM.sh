#!/bin/sh

supprimerVM()
{

echo veuillez selectionner la VM à supprimer.
read nom_vm


virsh destroy $nom_vm
virsh undefine $nom_vm

echo VM supprimée.
}

