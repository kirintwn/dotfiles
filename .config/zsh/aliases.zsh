alias sudo="sudo "
alias dotfiles="git --git-dir=$XDG_DATA_HOME/dotfiles/ --work-tree=$HOME"
alias d="dotfiles"
# see functions.zsh for "dofiles add" alias "da"

alias ls="eza --color=always --icons --group-directories-first"
alias tree="eza --color=always --icons --group-directories-first -T --git-ignore"
alias l.='eza -a | rg "^\."'
alias cat="bat"
alias catp="bat -p"
alias vi="nvim"
alias vim="nvim"
alias tf="terraform"
alias python="python3"
alias pip="pip3"

# print each PATH entry on a separate line
alias printpath='print -rl $path'

# print my public ip
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
