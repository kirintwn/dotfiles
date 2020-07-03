alias dotfiles="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias d="dotfiles"
# see functions.zsh for "dofiles add"'s alias "da"

alias ls="exa --color=always --icons --group-directories-first"
alias tree="exa --color=always --icons --group-directories-first -T --git-ignore"
alias cat="bat"
alias catp="bat -p"
alias vi="nvim"
alias vim="nvim"
alias htop="glances"

# print each PATH entry on a separate line
alias printpath='print -rl $path'

# print my public ip
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
