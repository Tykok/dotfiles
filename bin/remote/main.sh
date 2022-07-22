#!/bin/bash

# Chemin vers ce script
PATH_OF_SCRIPT=$(dirname $(realpath $0))

# Fichier contenant les différentes fonctions utiles
source $PATH_OF_SCRIPT/function.sh
# On récupére maintenant la configuration du script
source $PATH_OF_SCRIPT/main.conf

################################################################################################################################
# RECUPERATION DES PARAMETRES
################################################################################################################################

# Arguments nécessaires à l'exécution du script
ARG_destination=""
ARG_file_to_send=""
ARG_bash_command=""
ARG_script=$0

# On récupére les différents paramètres
for arg in "$@"; do
    argument=$(echo "$arg" | cut -d"=" -f2)
    option=$(echo "$arg" | cut -d"=" -f1)
    case $option in

    --dest | -dest)
        ARG_destination=${argument^^}
        ;;

    --file | -file)
        ARG_file_to_send=$argument
        ;;

    --command | -command)
        ARG_bash_command=$argument
        ;;

    --help | -h | --h | -help)
        if [ $ARG_script == "scpto.sh" ]; then
            help_scpto
            exit 0
        elif [ $ARG_script == "remoteshell.sh" ]; then
            help_remoteshell
            exit 0
        else
            echo -e "${color[red]}Erreur : Le script n'est pas connu${color[normal]}"
            exit 1
        fi
        ;;

    --version | --v | -version | -v)
        if [ $ARG_script == "scpto.sh" ]; then
            ascii_draw_scpto
            echo -e "	Version : ${color[bold]}$VERSION_SCPTO${color[normal]}"
            exit 0
        elif [ $ARG_script == "remoteshell.sh" ]; then
            ascii_draw_remoteshell
            echo -e "	Version : ${color[bold]}$VERSION_REMOTESHELL${color[normal]}"
            exit 0
        else
            echo -e "${color[red]}Erreur : Le script n'est pas connu${color[normal]}"
            exit 1
        fi
        ;;

    *)
        echo -e "${color[red]}Une liste d'option spécifique doit être indiqué.\nL'option \"$option\" n'est pas reconnu\n.${color[normal]}"
        help
        exit 1
        ;;

    esac
done

# on vérifie que les paramètres ont bien été envoyés
if [[ $ARG_script == "scpto.sh" && -z "$ARG_file_to_send" ]]; then
    echo -e "${color[red]}L'option --file n'est pas renseignée\n${color[normal]}"
    help_scpto
    exit 1
elif [[ $ARG_script == 'remoteshell.sh' && -z "ARG_bash_command" ]]; then
    echo -e "${color[red]}L'option --command n'est pas renseignée\n${color[normal]}"
    help_remoteshell
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
eval "DEST=\$DEST_$ARG_destination"
echo -e "${color[normal]}Adresse de destination : ${color[green]}$DEST"

eval "USER=\$USER_$ARG_destination"
echo -e "${color[normal]}Utilisateur du serveur de destination : ${color[green]}$USER"

eval "KEYSSH=\$KEYSSH_$ARG_destination"
echo -e "${color[normal]}Fichier d'identification de la clé SSH : ${color[green]}$KEYSSH"

eval "PORT=\$PORT_$ARG_destination"
echo -e "${color[normal]}Port de connexion au serveur de destination : ${color[green]}$PORT"

FOLDER=""
if [ $ARG_script == "scpto.sh" ]; then
    eval "FOLDER=\$FOLDER_$ARG_destination"
    echo -e "${color[normal]}Dossier de destination sur le serveur de destination : ${color[green]}$FOLDER"
fi
