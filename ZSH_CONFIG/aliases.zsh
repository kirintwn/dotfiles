function dsf() {
    diff -u $@ | delta --theme="Dracula"
}

alias dotfiles="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
alias d="dotfiles"

alias ls="exa --color=always --icons --group-directories-first"
alias tree="exa --color=always --icons --group-directories-first -T"
alias cat="bat"
alias htop="glances"
