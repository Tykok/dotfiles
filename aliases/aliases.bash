# Python
python-create-env() {
  python$1 -m venv env && source env/bin/activate
}

pip-save(){
  pip install $1 && pip freeze > requirements.txt
}

alias python3.9-create-env="python3.9 -m venv env && source env/bin/activate"
pip-save(){ pip install $1 && pip freeze > requirements.txt }
alias python-activate="source env/bin/activate"
alias pip-install="pip install -r requirements.txt"
# PlantUML
# alias plantuml='java -jar /home/tykok/bin/plantuml/plantuml.jar'

# SchemaSpy
# alias schemaspy='java -jar bin/schemaspy/schemaspy-6.1.0.jar'

# Git
git-alias(){ git config --global alias.$1 $2 }
alias git-a='git add'
alias git-aa='git add .'
alias git-c='git commit'
alias git-cm='git commit -m'
alias git-log1='git log --oneline'
alias git-log-graph="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
alias git-push='git push origin $(git-current-branch)'
alias git-current-branch='git rev-parse --abbrev-ref HEAD'
alias git-add-amend='git add . && git commit --amend'
alias git-amend-and-push='git-add-amend && git push origin $(git rev-parse --abbrev-ref HEAD) -f'
alias git-rebase-from-develop='git fetch origin && git rebase origin/develop'

# dotnet
dotnet6-new(){ mkdir $1 && cd $1 && dotnet new console --framework net6.0 }

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Others and commons
alias agu='sudo apt-get update'
alias zsh-update='source ~/.zshrc'
search-port() {
	eval "lsof -i tcp:$1"
}
