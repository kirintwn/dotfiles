### Zinit's installer
if [[ ! -f "$ZINITDIR"/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$ZINITDIR" && command chmod g-rwX "$ZINITDIR"
  command git clone https://github.com/zdharma/zinit "$ZINITDIR"/bin && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZINITDIR"/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer

# powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# OMZ libs
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/git.zsh

# OMZ plugins
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/aws/aws.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
zinit ice svn
zinit snippet OMZ::plugins/extract

# zsh-completions
zinit ice blockf
zinit light zsh-users/zsh-completions

# asdf
zinit light asdf-vm/asdf

# bat
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# exa
zinit ice from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa
zinit ice as"completion" mv"c* -> _exa"
zinit snippet "https://github.com/ogham/exa/blob/master/contrib/completions.zsh"

# jq
zinit ice from"gh-r" as"program" mv"jq* -> jq"
zinit light stedolan/jq

# fd
zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# rg
zinit ice as"program" from"gh-r" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

# fzf
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf-bin
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/completion.zsh"
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh"

# delta
zinit ice as"program" from"gh-r" mv"delta* -> delta" pick"delta/delta"
zinit light dandavison/delta

# z.lua
# Prerequisites:
# * asdf - install from zinit
# * lua - install from asdf
zinit light skywind3000/z.lua

# fzf-tab
zinit light Aloxaf/fzf-tab

# fast-syntax-highlighting
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
