#!/bin/bash
source ./fonction/CreeVM.sh
source ./fonction/Affichage.sh
tete_de_page

echo "Editeur de création de vm"
echo "Nom de la nouvelle vm"
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
