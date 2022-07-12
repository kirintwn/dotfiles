# chamber
alias chamberxp="AWS_PROFILE=xendit CHAMBER_AWS_REGION=us-west-2 chamber"
alias chamberxs="AWS_PROFILE=xendit-staging CHAMBER_AWS_REGION=us-west-2 chamber"
alias chambern="AWS_PROFILE=nex CHAMBER_AWS_REGION=ap-southeast-3 chamber"

# awscli
alias awsxp="aws --profile xendit"
alias awsxs="aws --profile xendit-staging"
alias awsn="aws --profile nex"

# k9s
alias k9sxp="k9s --context trident-production-0"
alias k9sxs="k9s --context trident-staging-0"
alias k9snp="k9s --context trident-nex-production-jkt-3"
alias k9sna="k9s --context alicloud-nex"

# kubectl
alias kxp="kubectl --context trident-production-0"
alias kxs="kubectl --context trident-staging-0"
alias knp="kubectl --context trident-nex-production-jkt-3"
alias kna="kubectl --context alicloud-nex"
