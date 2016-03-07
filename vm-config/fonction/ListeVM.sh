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
