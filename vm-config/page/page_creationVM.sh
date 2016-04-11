#!/bin/bash
source ./fonction/CreeVM.sh
source ./fonction/infoServeur.sh
source ./fonction/Affichage.sh
tete_de_page
echo
echo "          Gestionnaire de création d'une VM"
echo
echo
echo "               ---Info du serveur--- "
echo "------------------------------------------------------------"
echo "CPU"
echo -n "Nombre de CPU :"
nb_cpu_serveur
echo -n "Model de CPU  :"
nom_cpu_serveur
echo 
echo "------------------------------------------------------------"
echo "Espace disque"
nbr_espace_disque_serveur
echo
echo "------------------------------------------------------------"
echo "RAM"
echo -n "Memoire ram total (Go)   :"
nbr_ram_total
echo -n "Memoire ram utilise (GO) :"
nbr_ram_utilise
echo -n "Memoire ram libre (GO)   :"
nbr_ram_libre
echo 
echo "------------------------------------------------------------"
echo
echo "Nom de votre nouvelle vm"
zone_saisie
read lire_nom_vm
echo "Nombre de CPU"
zone_saisie
read lire_nombre_cpu
echo "Mémoire (Mo)"
zone_saisie
read lire_nombre_memoire
echo "Taille disque (Mo)"
zone_saisie
read lire_taille_disque

CreationVM $lire_nom_vm $lire_nombre_cpu $lire_nombre_memoire $lire_taille_disque

Sleep 3

./page/page_gestion_vm.sh
