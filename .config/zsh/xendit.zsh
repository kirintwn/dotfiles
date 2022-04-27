# chamber default region
export CHAMBER_AWS_REGION=us-west-2

# chamber
alias chamberxs="AWS_PROFILE=xendit-staging chamber"
alias chamberxp="AWS_PROFILE=xendit chamber"

# awscli
alias awsxs="aws --profile xendit-staging"
alias awsxp="aws --profile xendit"

# k9s
alias k9sxd="k9s --context trident-playground-0"
alias k9sxs="k9s --context trident-staging-0"
alias k9sxp="k9s --context trident-production-0"

# kubectl
alias kxd="kubectl --context trident-playground-0"
alias kxs="kubectl --context trident-staging-0"
alias kxp="kubectl --context trident-production-0"
