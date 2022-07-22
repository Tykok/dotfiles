#!/bin/bash
source main.sh

################################################################################################################################
# EXECUTION DE LA COMMANDE
################################################################################################################################

echo -e "${color[normal]}Exécution de la commande ${color[green]}$ARG_bash_command${color[normal]} sur ${color[green]}$DEST${color[normal]} : "

echo -e "${color[green]}----------------------------------------------------------------------------\n${color[normal]}"
echo -e "COMMANDE EXECUTE SUR $DEST\n"
ssh $USER@$DEST -i $KEYSSH -p $PORT -t $ARG_bash_command

# On vérifie que le script nous renvoie un succés / échec
if [ $? -eq 0 ]; then
    echo -e "${color[green]}----------------------------------------------------------------------------\n"
    echo -e "Succés${color[normal]}"
    exit 0
else
    echo -e "${color[red]}----------------------------------------------------------------------------\n"
    echo -e "Échéc${color[normal]}"
    exit $sortie
fi
