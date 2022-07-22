#!/bin/bash

PATH_OF_SCRIPT=$(dirname $(realpath $0))
source $PATH_OF_SCRIPT/function.sh
source $PATH_OF_SCRIPT/../pgsql.conf

# Vérification de l'accés à la commande psql
psql -c 'SELECT 1' -t

if [ $? -ne 0 ]; then
	echo -e "${color[red]}La commande 'psql' n'est pas disponible avec l'utilisateur $(whoami)${color[normal]}"
	echo -e "${color[yellow]}RRelancer le script avec un autre utilisateur${color[normal]}"
	exit 1
fi

################################################################################################################################
# RECUPERATION DES PARAMETRES
################################################################################################################################

# Arguments nécessaires à l'exécution du script
ARG_db_name=""
ARG_file=""
ARG_recreate=0
ARG_owner=""

# On récupére les différents paramètres
for arg in "$@"; do
	argument=$(echo "$arg" | cut -d"=" -f2)
	option=$(echo "$arg" | cut -d"=" -f1)
	case $option in

	--dbname | -dbname)
		ARG_db_name=$argument
		;;

	--file | -file)
		ARG_file=$argument
		;;

	--recreate | -recreate)
		ARG_recreate=1
		;;

	--owner | -owner)
		ARG_owner=$argument
		;;

	--help | -h | --h | -help)
		help
		exit 0
		;;

	--version | --v | -version | -v)
		ascii_draw
		echo -e "	Version : ${color[bold]}$VERSION_PGSQLRESTORE${color[normal]}"
		exit 0
		;;

	*)
		echo -e "${color[red]}Une liste d'option spécifique doit être indiqué.\nL'option \"$option\" n'est pas reconnu\n${color[normal]}"
		help
		exit 1
		;;

	esac
done

# on vérifie que les paramètres requis ont bien été envoyés
if [ -z "$ARG_db_name" ]; then
	echo -e "${color[red]}L'option --dbname n'est pas renseignée\n${color[normal]}"
	help
	exit 1
elif [ -z "$ARG_file" ]; then
	echo -e "${color[red]}L'option --file n'est pas renseignée\n${color[normal]}"
	help
	exit 1
fi

################################################################################################################################
# RECUPERATION DES PARAMETRES OPTIONNELS
################################################################################################################################

# On recrée la base de données avec l'owner si besoin
if [[ $ARG_recreate -eq 1 && ! -z $ARG_owner ]]; then
	psql -c "DROP DATABASE IF EXISTS $ARG_db_name"
	psql -c "CREATE DATABASE $ARG_db_name WITH OWNER $ARG_owner"
elif [ $ARG_recreate -eq 1 ]; then
	psql -c "DROP DATABASE IF EXISTS $ARG_db_name"
	psql -c "CREATE DATABASE $ARG_db_name"
fi

echo -e "${color[normal]}Restauration de la base de données ${color[green]}$ARG_db_name"
echo -e "\n${color[normal]}--------------------------------------------------------------------------"

psql -d $ARG_db_name -f $ARG_file

echo -e "\n${color[normal]}--------------------------------------------------------------------------"
echo -e "${color[normal]}Fin du script pgsqlrestore"
