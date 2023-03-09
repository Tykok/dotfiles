source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc


alias postgres-proxy="cloud-sql-proxy picta-int:us-central1:postgre-mvp 'picta-int:us-central1:postgre-mvp?unix-socket=/tmp/cloudsql'"
alias postgres-proxy-create-and-run="sudo mkdir /tmp/cloudsql; sudo chmod 777 /tmp/cloudsql && postgres-proxy"
