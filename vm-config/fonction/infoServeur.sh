#!/bin/bash
nb_cpu_serveur()
{
	cat /proc/cpuinfo | grep "processor"| awk 'END {print}' | awk {'print $3'}
}

nom_cpu_serveur()
{
	cat /proc/cpuinfo | grep "model name"| awk 'END {print}' | cut -c14-
}
nbr_espace_disque_serveur()
{
	df -h | grep '^/'
}
nbr_ram_total()
{
	free -g | grep "Mem:" | awk {'print $2'}
}
nbr_ram_utilise()
{
	free -g | grep "Mem:" | awk {'print $3'}
}
nbr_ram_libre()
{
	free -g | grep "Mem:" | awk {'print $4'}
}