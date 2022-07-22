source main.sh

################################################################################################################################
# ENVOI DU FICHIER / REPERTOIRE
################################################################################################################################

sortie=0
if [ -f $ARG_file_to_send ]; then
	echo -e "${color[normal]}Envoi du fichier ${color[green]}$ARG_file_to_send${color[normal]} vers ${color[green]}$DEST${color[normal]} : "
	scp -i $KEYSSH -P $PORT $ARG_file_to_send $USER@$DEST:$FOLDER
	sortie=$?
elif [ -d $ARG_file_to_send ]; then
	echo -e "${color[normal]}Envoi du répertoire ${color[green]}$ARG_file_to_send${color[normal]} vers ${color[green]}$DEST${color[normal]} : "
	scp -r -i $KEYSSH -P $PORT $ARG_file_to_send $USER@$DEST:$FOLDER
	sortie=$?
else
	echo -e "${color[red]}La valeur ${color[bold]}$ARG_file_to_send${color[red]} de l'option --file n'est pas un fichier / répertoire."
	echo -e "${color[normal]}Vérifiez que celui-ci est existant et relancez le script"
	exit 1
fi
