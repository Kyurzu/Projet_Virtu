#!/bin/bash
etatActif()
{
	nom_vm=$1
	virsh start $nom_vm
}

etatArret_douce()
{
	nom_vm=$1
	virsh shutdown $nom_vm

}

etatArret_brutal()
{
	nom_vm=$1
	virsh destroy $nom_vm

}

etatAutostart()
{
	nom_vm=$1
	virsh autostart $nom_vm
}

desactiveEtatAutostart()
{
	nom_vm=$1
	virsh autostart $nom_vm --disable
}
