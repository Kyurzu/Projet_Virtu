#!/bin/bash
source ./fonction/Log.sh

#Permet de démarrer la VM
etatActif()
{
	nom_vm=$1
	virsh start $nom_vm >> system/log_vm/Log_Osiris.log 

}

#Arrête de manière douce la VM
etatArret_douce()
{
	nom_vm=$1
	virsh shutdown $nom_vm >> system/log_vm/Log_Osiris.log 
}

#Arrête de manière brutal la VM
etatArret_brutal()
{
	nom_vm=$1
	virsh destroy $nom_vm >> system/log_vm/Log_Osiris.log 2>&1
}


#Redémarre la VM
etatReboot()
{
	nom_vm=$1
	virsh reboot $nom_vm >> system/log_vm/Log_Osiris.log
}

#Permet de faire un démarrage automatique pour la VM
etatAutostart()
{
	nom_vm=$1
	virsh autostart $nom_vm >> system/log_vm/Log_Osiris.log
}

#Retire le mode démarrage automatique de la VM
desactiveEtatAutostart()
{
	nom_vm=$1
	virsh autostart $nom_vm --disable >> system/log_vm/Log_Osiris.log
}
