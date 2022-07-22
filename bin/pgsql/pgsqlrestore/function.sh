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
       echo '                            __               __                '
       echo '    ____  ____ __________ _/ /_______  _____/ /_____  ________ '
       echo '   / __ \/ __  / ___/ __  / / ___/ _ \/ ___/ __/ __ \/ ___/ _ \'
       echo '  / /_/ / /_/ (__  ) /_/ / / /  /  __(__  ) /_/ /_/ / /  /  __/'
       echo ' / .___/\__, /____/\__, /_/_/   \___/____/\__/\____/_/   \___/ '
       echo '/_/    /____/        /_/                                       '
       echo -e "\n${color[normal]}"
}

function help() {
       # Dessin ascii du projet
       ascii_draw

       tee <<EOF
       Commande pgsqlrestore

       NAME
         pgsqlrestore - Postgre SQL Restore Database

       SYNOPSIS
         pgsqlrestore --dbname=... --file=... [--recreate ; --owner=...]

       DESCRIPTION
         La commande pgsqlrestore permet de restaurer une base de données grâce à partir d'un fichier .sql.
         Ce script ce base sur le fichier de configuration pgsql.conf.

-------------------------------------------------------------------------------------------------------------
       OPTIONS

              --file / -file
                     Fichier ou se trouve le dump

                     --file=/home/.../fichier.sql

              --dbname / -dbname
                     Permet de spécifier la base de données à restaurer.
                     
                     --dbname=test   
              
              --recreate / -recreate
                     Permet de spécifier si la base de données doit être recréer (DROP and CREATE).
                     
                     --recreate

              --owner / -owner
                     Permet de spécifier le propriétaire de la base de données (doit être accompagné de l'option --recreate).
                     
                     --owner=user

              --help 
                     Montre cette aide.

              --version
                     Version de la commande pgsqlrestore.

EOF
}
