########################################################################################################
# SOURCE
########################################################################################################

# source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
# source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(oh-my-posh init zsh)"

fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i

## EXA
alias ls='exa --icons --group-directories-first'
alias ll='exa -l --icons --no-user --group-directories-first  --time-style long-iso'
alias la='exa -la --icons --no-user --group-directories-first  --time-style long-iso'

########################################################################################################
########################################################################################################

# Postgres Google Proxy
alias postgres-proxy-reset-and-run="rm -rf /tmp/cloudsql && postgres-proxy-create-and-run && postgres-proxy"
alias postgres-proxy="cloud-sql-proxy picta-int:us-central1:postgre-mvp 'picta-int:us-central1:postgre-mvp?unix-socket=/tmp/cloudsql'"
alias postgres-proxy-create-and-run="sudo mkdir /tmp/cloudsql; sudo chmod 777 /tmp/cloudsql && postgres-proxy"
alias postgres-proxy-prd="cloud-sql-proxy picta-prd:us-central1:postgre13-prd 'picta-int:us-central1:postgre-mvp?unix-socket=/tmp/cloudsql'"

export PGPASSFILE='/Users/elietreport/.pgpass'
