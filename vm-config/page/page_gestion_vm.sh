#!/bin/bash
source ./fonction/ListeVM.sh
source ./fonction/Affichage.sh

tete_de_page
echo
echo -e "<== \033[31;1;4;5;7m[0]\033[0m Pour quitter VM configuration"
echo
listVM_General
echo -e "Inscrire l'ID de votre VM ou \033[31;1;4;5;7m[+]\033[0m pour cree une VM"

zone_saisie
read choix_id

if [ $choix_id = "+" ]
	then
	./page/page_creationVM.sh

elif [ $choix_id -eq 0 ]
  	then
	exit 0

else
choix_id=$((choix_id + 2))
nombreLigne=`virsh list --all | wc -l`

nom_vm=`virsh list --all | sed -n ${choix_id}p | awk {'print $2'}`
fi
if [ "$(echo $choix_id | grep "^[ [:digit:] ]*$")" ]
	then
	if [ $choix_id -ge $nombreLigne ] || [ $choix_id -le 2 ]
		then
		echo "Reponse non comprise"
		sleep 3
		./page/page_gestion_vm.sh
	fi
fi
if [ $nom_vm = "debian8-tpl" ]
	then
	echo "Ceci est la vm d'origine interdiction d'y acceder !"
	sleep 3
	./page/page_gestion_vm.sh
fi
./page/page_option_vm.sh $nom_vm