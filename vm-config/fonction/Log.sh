#!/bin/bash

#Edit le fichier de log
editLog()
{
	nom_evenement=$1
	nom_vm=$2
	echo "${nom_evenement} --- ${nom_vm} --- `date '+%d/%m/%Y %H:%M'`" >> system/evenement.log
}

#Créé un fichier de LOG
creeFichierLog()
{
	nom_vm=$1
	date_maj_jour=`date +%e/%m/%Y`
	date_maj_heure=`date +%H:%M`
	if [ ! -f "system/log_vm/Log_${nom_vm}.log" ]
		then
		echo "Fichier de logs de la machine virtuel ${nom_vm}" > system/log_vm/Log_${nom_vm}.log
		echo "Date de création :le ${date_maj_jour} à ${date_maj_heure}" >> system/log_vm/Log_${nom_vm}.log
		echo "*************************************************************************************" >> system/log_vm/Log_${nom_vm}.log
	else
		premiere_ligne=`cat system/log_vm/Log_${nom_vm}.log | sed -n 1p`
		deuxieme_ligne=`cat system/log_vm/Log_${nom_vm}.log | sed -n 2p`
		echo "${premiere_ligne}" > system/log_vm/Log_${nom_vm}.log
		echo "${deuxieme_ligne}" >> system/log_vm/Log_${nom_vm}.log
		echo "*************************************************************************************" >> system/log_vm/Log_${nom_vm}.log
	fi
}

#Ajout de la configuration des VM dans les log
configurationVM_Log()
{
	nom_vm=$1
	lien=`sed -n 1p system/lien.txt`
	echo >> system/log_vm/Log_${nom_vm}.log
	echo "Configuration de la VM :" >> system/log_vm/Log_${nom_vm}.log
	echo "Nombre de CPU :`virsh dominfo $nom_vm | grep "CPU(s)" | awk {'print $2'}`" >> system/log_vm/Log_${nom_vm}.log
	echo "Memoire RAM :`virsh dominfo $nom_vm | grep "Max memory" | awk {'print $3'}`" >> system/log_vm/Log_${nom_vm}.log
	echo "Memoire swap :`du -h ${lien}${nom_vm}.qcow2 | awk {'print $1'}`" >> system/log_vm/Log_${nom_vm}.log
}

#Supprime les log
suprimmerLog()
{
	nom_vm=$1
	rm system/log_vm/Log_${nom_vm}.log
}

#Indique la date des log
dateLog()
{
	nom_vm=$1
	date_maj_jour=`date +%e/%m/%Y`
	date_maj_heure=`date +%H:%M`
	echo "le ${date_maj_jour} à ${date_maj_heure} :" >> system/log_vm/Log_${nom_vm}.log
}
