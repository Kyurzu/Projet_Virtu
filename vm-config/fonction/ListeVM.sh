#!/bin/sh

listVM()
{

virsh list -all

echo Entrez le nom de la VM pour voir son détail:
read nom_vm

virsh dominfo $nom_vm | grep Nam | grep State | grep CPU\(s\) | grep Max\ memory | grep Used\ memory | grep Autostart

}
