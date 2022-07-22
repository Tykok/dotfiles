# Import this file with source /path/color.sh to use color
declare -A color=(
       [red]="\e[31m"
       [normal]="\e[0m"
       [yellow]="\e[33m"
       [green]="\e[32m"
       [bold]="\e[1m"
)

function ascii_draw() {
       echo -e "${color[green]}"
       echo -E '    ____                                  __        __          __                     '
       echo -E '   / __ \ __  __ ____ ___   ____     ____/ /____ _ / /_ ____ _ / /_   ____ _ _____ ___ '
       echo -E '  / / / // / / // __  __ \ / __ \   / __  // __  // __// __  // __ \ / __  // ___// _ \'
       echo -E ' / /_/ // /_/ // / / / / // /_/ /  / /_/ // /_/ // /_ / /_/ // /_/ // /_/ //__  //  __/'
       echo -E '/_____/ \__ _//_/ /_/ /_//  ___/   \__ _/ \__ _/ \__/ \__ _//_ ___/ \__ _//____/ \___/ '
       echo -E '                        /_/                                                            '
       echo -e "\n${color[normal]}"
}

function help() {
       # Dessin ascii du projet
       ascii_draw

       tee <<EOF
       Commande pgsqldump

       NAME
         pgsqldump - Postgre SQL Dump Database

       SYNOPSIS
         pgsqldump --dest=... --dbname=... [--file=... ; --verbose]

       DESCRIPTION
         pgsqldump permet de récupérer un dump de la base de données, grâce à la commande
         pg_dump.
         Ce script ce base sur le fichier de configuration pgsqldump.conf .

-------------------------------------------------------------------------------------------------------------
       PREREQUIS 

       Avoir la configuration nécessaire pour récupérer le dump d'une base de données.
       Voici l'explication du fichier pgsqldump.conf :

       Adresse IP / Nom de domaine du destinaire :
              {DEST}_DEST=0.0.0.0
       
       Utilisateur permettant la connexion à la base de données : 
              {DEST}_USER=user
       
       Port de connexion Postgre SQL :
              {DEST}_PORT=5432
       
       Dossier de destination du dump : 
              {DEST}_FOLDER=/tmp/

       A savoir que {DEST} sera la variable renseigné dans l'option --dest, celle-ci doit OBLIGATOIREMENT être en majuscule
       dans le fichier de configuration du script.

-------------------------------------------------------------------------------------------------------------
       OPTIONS

              --file / -file
                     Fichier / répertoire qui recevra le dump

                     --file=/home/.../fichier.sql

              --dest / -dest
                     Permet de spécifier le serveur cible ou récupérer le dump de la base de données.
                     

                     --dest=PROD

              --help 
                     Montre cette aide.

              --version
                     Version de la commande pgsqldump.

EOF
}
