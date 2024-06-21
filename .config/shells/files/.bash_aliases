alias vim='/usr/local/bin/nvim'
alias update-discord="~/scripts/update-discord.sh"
alias k='kubectl'
alias ksn='set_kube_namespace'
alias neofetch='fastfetch'

function set_kube_namespace() {
    kubectl config set-context --current --namespace="${1}"
}
