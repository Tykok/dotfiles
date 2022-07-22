#!/bin/bash

PATH_OF_SCRIPT=$(dirname $(realpath $0))
source $PATH_OF_SCRIPT/function.sh
source $PATH_OF_SCRIPT/../pgsql.conf

################################################################################################################################
# RECUPERATION DES PARAMETRES
################################################################################################################################

# Arguments nécessaires à l'exécution du script
ARG_destination=""
ARG_db_name=""
ARG_file=""
ARG_verbose=0

# On récupére les différents paramètres
for arg in "$@"; do
    argument=$(echo "$arg" | cut -d"=" -f2)
    option=$(echo "$arg" | cut -d"=" -f1)
    case $option in

    --dest | -dest)
        ARG_destination=${argument^^}
        ;;

    --dbname | -dbname)
        ARG_db_name=$argument
        ;;

    --file | -file)
        ARG_file=$argument
        ;;

    --verbose | -verbose)
        ARG_verbose=1
        ;;

    --help | -h | --h | -help)
        help
        exit 0
        ;;

    --version | --v | -version | -v)
        ascii_draw
        echo -e "	Version : ${color[bold]}$VERSION_PGSQLDUMP${color[normal]}"
        exit 0
        ;;

    *)
        echo -e "${color[red]}Une liste d'option spécifique doit être indiqué.\nL'option \"$option\" n'est pas reconnu\n${color[normal]}"
        help
        exit 1
        ;;

    esac
done

# on vérifie que les paramètres ont bien été envoyés
if [ -z "$ARG_db_name" ]; then
    echo -e "${color[red]}L'option --dbname n'est pas renseignée\n${color[normal]}"
    help
    exit 1
elif [ -z "$ARG_destination" ]; then
    echo -e "${color[red]}L'option --dest n'est pas renseignée\n${color[normal]}"
    help
    exit 1
fi

################################################################################################################################
# RECUPERATION DES VALEURS DU FICHIER CONF
################################################################################################################################

echo -e "\nRappel des différentes valeurs utilisés : \n"
# On récupére les différentes variables du fichier de configuration
eval "DEST=\$$ARG_destination$(echo '_DEST')"
echo -e "${color[normal]}Serveur de base de données : ${color[green]}$DEST"

eval "USER=\$$ARG_destination$(echo '_USER')"
echo -e "${color[normal]}Utilisateur de la base de données : ${color[green]}$USER"

eval "PORT=\$$ARG_destination$(echo '_PORT')"
echo -e "${color[normal]}Port de connexion au serveur de base de données : ${color[green]}$PORT"

# On vérifie que le dossier du dump a été renseigné, sinon on prend ce qui se trouve dans le fichier de configuration
if [ -z "$ARG_file" ]; then
    eval "ARG_file=\$$ARG_destination$(echo '_FILE')"
    ARG_file="$ARG_destination"
fi

if [ -d $ARG_file ]; then
    echo -e "${color[normal]}Dossier de destination du dump : ${color[green]}$ARG_file"
    ARG_file="$(echo $ARG_file)$(echo $ARG_db_name)_$(date +"%d-%m-%y").sql"
elif [ -f $ARG_file ]; then
    echo -e "${color[normal]}Fichier de destination du dump : ${color[green]}$ARG_file"
else
    echo -e "${color[normal]}Erreur, le fichier ${color[green]}$ARG_file${color[normal]} n'est pas accessible."
    exit 1
fi

echo -e "${color[normal]}Chemin complet vers le dump : ${color[green]}$ARG_file${color[normal]}"

if [ $ARG_verbose -eq 0 ]; then
    pg_dump --format=p --file=$ARG_file --verbose --port=$PORT --username=$USER --host=$DEST --dbname=mecavin
else
    pg_dump --format=p --file=$ARG_file --port=$PORT --username=$USER --host=$DEST --dbname=mecavin
fi
