#!/bin/zsh

OLD_DOTFILE=$(pwd)/old-dotfiles
if [ ! -d "$OLD_DOTFILE" ]; then
    mkdir $OLD_DOTFILE
fi


for DOTFILE in $(ls -a|grep '^\.[a-zA-Z0-9]')
do
    if [[ $DOTFILE == ".git" || $DOTFILE == ".gitignore" || $DOTFILE == ".zshrc" ]]; then
        continue
    fi

    if [[ -f ~/$DOTFILE  || -L ~/$DOTFILE ]]; then
        mv ~/$DOTFILE $OLD_DOTFILE
    fi
    ln $DOTFILE ~/$DOTFILE
done

source ~/.zshrc