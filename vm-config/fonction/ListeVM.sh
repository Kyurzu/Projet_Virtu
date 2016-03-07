#!/bin/sh

listVM_General()
{

virsh list --all

}
listVM_Detail()
{
nom_vm=$1
virsh dominfo $nom_vm | grep '\(Nom\|État\|CPU\|\Mémoire Max\|Mémoire utilisée\|Démarrage automatique\)'
}

Affiche_nom_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Nom
}

Affiche_CPU_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep CPU
}

Affiche_state_VM()
{
nom_vm=$1
virsh dominfo $nom_vm | grep État
}
Affiche_memoire_utiliser()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Mémoire utilisée
}
Affiche_memoire_max()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Mémoire Max
}
Affiche_autostart()
{
nom_vm=$1
virsh dominfo $nom_vm | grep Démarrage automatique
}
Affiche_memoire_disque()
{
nom_vm=$1
}
