# aws login cron job
alias reload-credentials="pm2 start ~/scripts/get-all-credentials.sh --cron \"*/30 * * * *\" --no-autorestart"

# eks config
alias k8s-eks-spn-d="aws eks update-kubeconfig --name spn-eks-dev --profile spn-dev"
alias k8s-eks-spn-s="aws eks update-kubeconfig --name spn-eks-stg --profile spn-stg"
alias k8s-eks-spn-p="aws eks update-kubeconfig --name spn-eks-prod --profile spn-prod"

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
