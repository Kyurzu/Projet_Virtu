#!/bin/bash

#Affiche le nombre de cpu du serveur
nb_cpu_serveur()
{
	lscpu | grep "CPU(s)" | cut -c24 | head -n 1 
}

#Affiche le nom du cpu du serveur
nom_cpu_serveur()
{
	cat /proc/cpuinfo | grep "model name"| awk 'END {print}' | cut -c14-
}

#Affiche l'espace utilisé et utilisable du disque dur
nbr_espace_disque_serveur()
{
	df -h | grep '/var' | cut -c44-47
}

#Affiche la RAM total du serveur
nbr_ram_total()
{
	free -g | grep "Mem:" | awk {'print $2'}
}

#Affiche la RAM utilisé par le serveur et ses VM
nbr_ram_utilise()
{
	free -g | grep "Mem:" | awk {'print $3'}
}

#Affiche la RAM disponible
nbr_ram_libre()
{
	free -g | grep "Mem:" | awk {'print $4'}
}
