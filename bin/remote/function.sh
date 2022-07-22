# Import this file with source /path/color.sh to use color
declare -A color=(
       [red]="\e[31m"
       [normal]="\e[0m"
       [yellow]="\e[33m"
       [green]="\e[32m"
       [bold]="\e[1m"
)

function ascii_draw_scpto() {
       echo -e "${color[green]}"
       echo -E "                _        "
       echo -E " ___  ___ _ __ | |_ ___  "
       echo -E "/ __|/ __| '_ \| __/ _ \ "
       echo -E "\__ \ (__| |_) | || (_) |"
       echo -E "|___/\___| .__/ \__\___/ "
       echo -E "         |_|             "
       echo -e "\n${color[normal]}"
}

function ascii_draw_remoteshell() {
       echo -e "${color[green]}"
       echo -E " _____               _              _       _ _ "
       echo -E "| __  |___ _____ ___| |_ ___    ___| |_ ___| | |"
       echo -E "|    -| -_|     | . |  _| -_|  |_ -|   | -_| | |"
       echo -E "|__|__|___|_|_|_|___|_| |___|  |___|_|_|___|_|_|"
       echo -e "\n${color[normal]}"
}

function help_scpto() {
       # Dessin ascii du projet
       ascii_draw_scpto

       tee <<EOF
       Commande scpto

       NAME
         scpto - Secure Copy To

       SYNOPSIS
         scpto --file=... --dest=... [OPTION]

       DESCRIPTION
         scpto permet d'envoyer un fichier / répertoire à un destinataire donné, dont les informations sont écrites dans
         le fichier main.conf 

-------------------------------------------------------------------------------------------------------------
       PREREQUIS 

       Avoir la configuration nécessaire pour l'envoi d'un fichier / répertoire.
       Voici l'explication du fichier main.conf :

       Adresse IP / Nom de domaine du destinaire :
              DEST_{DEST}=0.0.0.0
       
       Utilisateur permettant la connexion au serveur distant : 
              USER_{DEST}=user
       
       Clé SSH permettant de s'identifier sans mot de passe : 
              KEYSSH_{DEST}=/home/.../.ssh/id_rsa
       
       Port de connexion SSH :
              PORT_{DEST}=22
       
       Dossier de destination du serveur : 
              FOLDER_{DEST}=/tmp/

       A savoir que {DEST} sera la variable renseigné dans l'option --dest, celle-ci doit OBLIGATOIREMENT être en majuscule
       dans le fichier de configuration du script.

-------------------------------------------------------------------------------------------------------------
       OPTIONS

              --file / -file
                     Fichier / répertoire à envoyer

                     --file=/home/.../fichier.txt

              --dest / -dest
                     Permet de spécifier les paramètres à récupérer dans le fichier de configuration (Adresse du destinataire, 
                     utilisateur, port, clé SSH à utiliser, dossier de destination)

                     --dest=PROD

              --help 
                     Montre cette aide.

              --version
                     Version de la commande scpto.

EOF
}

function help_remoteshell() {
       # Dessin ascii du projet
       ascii_draw_remoteshell

       tee <<EOF
       Commande remoteshell

       NAME
         remoteshell - Remote SHELL

       SYNOPSIS
         remoteshell --command=... --dest=... [OPTION]

       DESCRIPTION
         remoteshell permet d'exécuter une commande sur le serveur fournisdans l'option --dest.
         Les informations permettant d'envoyer des données sont écrites dans le fichier main.conf


-------------------------------------------------------------------------------------------------------------
       PREREQUIS 

       Avoir la configuration nécessaire pour l'exécution d'un script à distance.
       Voici l'explication du fichier main.conf :

       Adresse IP / Nom de domaine du destinaire :
              DEST_{DEST}=0.0.0.0
       
       Utilisateur permettant la connexion au serveur distant : 
              USER_{DEST}=user
       
       Clé SSH permettant de s'identifier sans mot de passe : 
              KEYSSH_{DEST}=/home/.../.ssh/id_rsa
       
       Port de connexion SSH :
              PORT_{DEST}=22

       A savoir que {DEST} sera la variable renseigné dans l'option --dest, celle-ci doit OBLIGATOIREMENT être en majuscule
       dans le fichier de configuration du script. En voici un exemple avec {DEST} qui prend la valeur "DEV" : 
              DEST_PROD=0.0.0.0

-------------------------------------------------------------------------------------------------------------
       OPTIONS

              --dest / -dest
                     Permet de spécifier les paramètres à récupérer dans le fichier de configuration (Adresse du destinataire, 
                     utilisateur, port, clé SSH à utiliser, dossier de destination)

                     --dest=PROD

              --help 
                     Montre cette aide.

              --version
                     Version de la commande remoteshell.

EOF
}
