# awscli
alias awsxs="aws --profile xendit-staging"
alias awsxp="aws --profile xendit"
alias awse="aws --profile eteam"

# eks config
function config-eks-kubeconfig() {
  aws --profile eteam eks update-kubeconfig \
    --name qa-eks --alias eteam-qa;  
  aws --profile eteam eks update-kubeconfig \
    --name stage-eks --alias eteam-stage;
  aws --profile eteam eks update-kubeconfig \
    --name prod-eks --alias eteam-prod;  
}

# k9s
alias k9sxd="k9s --context trident-playground-0"
alias k9sxs="k9s --context trident-staging-0"
alias k9sxp="k9s --context trident-production-0"
alias k9sed="k9s --context eteam-qa"
alias k9ses="k9s --context eteam-stage"
alias k9sep="k9s --context eteam-prod"

# kubectl
alias kxd="kubectl --context trident-playground-0"
alias kxs="kubectl --context trident-staging-0"
alias kxp="kubectl --context trident-production-0"
alias ked="kubectl --context eteam-qa"
alias kes="kubectl --context eteam-stage"
alias kep="kubectl --context eteam-prod"
