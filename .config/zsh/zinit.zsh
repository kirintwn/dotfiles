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
zinit snippet OMZ::plugins/helm/helm.plugin.zsh
zinit ice svn
zinit snippet OMZ::plugins/extract

# zsh-completions
zinit ice blockf
zinit light zsh-users/zsh-completions
zinit ice as"completion"
zinit snippet "https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker"
zinit ice as"completion"
zinit snippet "https://github.com/ogham/exa/blob/master/completions/zsh/_exa"

# fzf key bindings - https://github.com/junegunn/fzf#key-bindings-for-command-line
zinit snippet "https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh"

# z.lua
zinit light skywind3000/z.lua

# fzf-tab
zinit light Aloxaf/fzf-tab

# fast-syntax-highlighting
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions
