#!/bin/bash

#Liste les VM
listVM_General()
{
	Green="$(tput bold ; tput setaf 2)"
	Yellow="$(tput bold ; tput setaf 3)"
	bold=$(tput smso)
	offbold=$(tput rmso)
	ResetColor="$(tput sgr0)"
	nombreLigne=`virsh list --all | wc -l`

	indice=3
	id_vm=1
	indiceLigne=$(($indice + 3))
	echo " ID     Nom            Date de création           Etat           CPU           RAM"
	echo "---------------------------------------------------------------------------------------------"
	while test $indice != $nombreLigne
	do 
		tput cup $(($indiceLigne + 2)) 1
		echo -e "\033[31;1;4;5;7m"[${id_vm}]"\033[0m\c"

		valeur_NomVM=`virsh list --all | sed -n ${indice}p | awk {'print $2'}`

		if [ "${valeur_NomVM}" = "${VM_TEMPLATE}" ]
			then
			echo -e "    ${Yellow}${valeur_NomVM}${ResetColor}"

	else
		echo -e "    ${valeur_NomVM}"
	fi
	if [ ! "${valeur_NomVM}" = "${VM_TEMPLATE}" ]
		then
		tput cup $(($indiceLigne + 2)) 23

	    date_creation=`cat system/log_vm/Log_${valeur_NomVM}.log | grep "Date de création" | cut -c20-42`
		echo ${date_creation}
	else
		tput cup $(($indiceLigne + 2)) 23
		echo -e "${Yellow}*********************${ResetColor}"

	fi
		tput cup $(($indiceLigne + 2)) 50

		valeur_Etat=`virsh list --all | sed -n ${indice}p | awk {'print $3'}`

		if [ "${valeur_Etat}" = "running" ]
			then
			echo  "${Green}Démarrée${ResetColor}"
		fi

	if [ ! "${valeur_NomVM}" = "${VM_TEMPLATE}" ]
			then

		if [ "${valeur_Etat}" = "shut" ]
			then
			echo  "Arrêtée"
		fi
	else
		if [ "${valeur_Etat}" = "shut" ]
			then
			echo -e "${Yellow}Arrêtée${ResetColor}"
		fi
	fi
		tput cup $(($indiceLigne + 2)) 65
		Affiche_CPU_VM ${valeur_NomVM}

		tput cup $(($indiceLigne + 2)) 79
		echo `Affiche_memoire_max ${valeur_NomVM}`" Go" 
	    echo "---------------------------------------------------------------------------------------------"
		echo
		indiceLigne=$(($indiceLigne + 2))
		id_vm=$(($id_vm + 1))
		indice=$(($indice + 1))
	done

}

#Affiche le nom de la VM
Affiche_nom_VM()
{
	nom_vm=$1
	echo `virsh dominfo $nom_vm | grep Name | awk {'print $2'}`
}

#Affiche le nombre de CPU de la VM
Affiche_CPU_VM()
{
	nom_vm=$1
	echo `virsh dominfo $nom_vm | grep "CPU(s)" | awk {'print $2'}`
}


#Affiche l'état de la VM
Affiche_state_VM()
{
	nom_vm=$1
	echo `virsh dominfo $nom_vm | grep State | awk {'print $2,$3'}`
}

#Affiche la RAM utilisée
Affiche_memoire_utiliser()
{
	nom_vm=$1
	echo `virsh dominfo $nom_vm | grep "Used memory" | awk {'print $3/1024'}`
}

#Affiche la RAM max
Affiche_memoire_max()
{
	nom_vm=$1
	echo `virsh dominfo $nom_vm | grep "Max memory" | awk {'print $3/1024/1024'}`
}

#Affiche l'autostart
Affiche_autostart()
{
	nom_vm=$1
	echo `virsh dominfo $nom_vm | grep Autostart | awk {'print $2'}`
}

#Affiche la mémoire disuqe
Affiche_memoire_disque()
{
	nom_vm=$1
	lien=$VM_LIEN_IMAGE
	echo `du -h ${lien}${nom_vm}.qcow2 | awk {'print $1'}`

}

#Affiche l'IP de la VM
Affiche_IP()
{
	 nom_vm=$1
	 adresse_mac=`virsh dumpxml ${nom_vm} | grep "mac address" | cut -c21-37`
	 echo `arp -n | grep ${adresse_mac} | awk {'print $1'}`
	 
}

