#!/bin/bash

#Utilise les scripts ci dessous
source ./fonction/ListeVM.sh
source ./fonction/Affichage.sh

tete_de_page
echo
echo -e "<== \033[31;1;4;5;7m[0]\033[0m Pour quitter VM configuration"
echo
listVM_General
echo -e "Inscrivez l'ID de votre VM ou \033[31;1;4;5;7m[+]\033[0m pour cree une VM"

zone_saisie
read choix_id

if [ "${choix_id}" = "+" ]
	then
	./page/page_creationVM.sh

elif [ "${choix_id}" = "0" ]
  	then
  	exit 0

  elif [ ! "$(echo $choix_id | grep "^[ [:digit:] ]*$")" ]
	then
		echo "Reponse non comprise, entrez un nombre entier ou +"
		sleep 1
		./page/page_gestion_vm.sh
fi

choix_id=$((choix_id + 2))
nombreLigne=`virsh list --all | wc -l`
nombreLigne=$((nombreLigne - 1))

if [ ${choix_id} -gt ${nombreLigne} ]
	then
	echo "Reponse non comprise"
	sleep 1
	./page/page_gestion_vm.sh
fi

nom_vm=`virsh list --all | sed -n ${choix_id}p | awk {'print $2'}`

if [ $nom_vm = "debian8-tpl" ]
	then
	./page/infos_vm_original.sh $nom_vm
else
./page/page_option_vm.sh $nom_vm
fi
