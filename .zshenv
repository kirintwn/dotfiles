export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

# mkdir -p "$XDG_CONFIG_HOME"/asdf
# mkdir -p "$XDG_DATA_HOME"/{zsh,zlua,node,asdf}
# mkdir -p "$XDG_CACHE_HOME"/zcompdump

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/zsh_history

# zinit
declare -A ZINIT
ZINIT[HOME_DIR]="$ZDOTDIR"/.zinit
ZINIT[BIN_DIR]="$ZDOTDIR"/.zinit/bin
ZINIT[PLUGINS_DIR]="$ZDOTDIR"/.zinit/plugins
ZINIT[COMPLETIONS_DIR]="$ZDOTDIR"/.zinit/completions
ZINIT[SNIPPETS_DIR]="$ZDOTDIR"/.zinit/snippets
ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME"/zcompdump/zcompdump-zinit

# z.lua
export _ZL_DATA="$XDG_DATA_HOME"/zlua/.zlua

# asdf
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME"/asdf/asdfrc
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="$XDG_CONFIG_HOME"/asdf/tool-versions
export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf

# node.js
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/node_repl_history

# ToDo: python
# Reference: https://docs.python.org/3/library/readline.html?highlight=readline#example

# k9s
export K9SCONFIG="$XDG_CONFIG_HOME"/k9s

# Disable unneeded histories
## less
export LESSHISTFILE=-
## wget
alias wget="wget --no-hsts"
