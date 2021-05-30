# eks config
alias config-eks-spn-d="aws --profile spn-dev eks update-kubeconfig --name spn-eks-dev --alias spn-dev"
alias config-eks-spn-s="aws --profile spn-stg eks update-kubeconfig --name spn-eks-stg --alias spn-stg"
alias config-eks-spn-p="aws --profile spn-prod eks update-kubeconfig --name spn-eks-prod --alias spn-prod"

# awscli
alias awsd="aws --profile spn-dev"
alias awss="aws --profile spn-stg"
alias awsp="aws --profile spn-prod"

# k9s
alias k9sd="k9s --context spn-dev"
alias k9ss="k9s --context spn-stg"
alias k9sp="k9s --context spn-prod"

# kubectl
alias kd="kubectl --context spn-dev"
alias ks="kubectl --context spn-stg"
alias kp="kubectl --context spn-prod"
