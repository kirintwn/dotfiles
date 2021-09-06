# awscli
alias awsx="aws --profile xendit"
alias awse="aws --profile eteam"

# eks config
alias config-eks-e-q="aws --profile eteam eks update-kubeconfig --name qa-eks --alias eteam-qa"
alias config-eks-e-s="aws --profile eteam eks update-kubeconfig --name stage-eks --alias eteam-stage"
alias config-eks-e-p="aws --profile eteam eks update-kubeconfig --name prod-eks --alias eteam-prod"

# k9s
alias k9seq="k9s --context eteam-qa"
alias k9ses="k9s --context eteam-stage"
alias k9sep="k9s --context eteam-prod"

# kubectl
alias keq="kubectl --context eteam-qa"
alias kes="kubectl --context eteam-stage"
alias kep="kubectl --context eteam-prod"
