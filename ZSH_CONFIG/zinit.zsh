### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

### Misc config
local extract="
# trim input
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"
FZF_TAB_COMMAND=(
    fzf
    --ansi
    --expect='$continuous_trigger' # For continuous completion
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --cycle
    '--query=$query'
    '--header-lines=$#headers'
)
zstyle ":fzf-tab:*" command $FZF_TAB_COMMAND
zstyle ":fzf-tab:*" single-group ""
zstyle ":fzf-tab:complete:cd:*" extra-opts --preview=$extract'exa -1 --color=always --icons --group-directories-first $realpath'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
### End of Misc config

zinit ice depth=1
zinit light romkatv/powerlevel10k

# OMZ lib
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/git.zsh

# OMZ plugins
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/aws/aws.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
zinit snippet OMZ::plugins/alias-finder/alias-finder.plugin.zsh

# zsh completions
zinit ice blockf
zinit light zsh-users/zsh-completions

# Bin
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

zinit ice from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa

zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit ice as"program" from"gh-r" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf-bin

zinit ice as"program" from"gh-r" mv"delta* -> delta" pick"delta/delta"
zinit light dandavison/delta

zinit load agkozak/zsh-z

zinit light lukechilds/zsh-nvm

zinit ice atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
    atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
    as"program" pick"bin/pyenv" src"zpyenv.zsh" nocompile"!"
zinit light pyenv/pyenv

# fzf related stuff
zinit light Aloxaf/fzf-tab
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/completion.zsh"
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh"

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions
