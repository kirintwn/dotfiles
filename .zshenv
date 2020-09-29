export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Please create some dirs for some program to use XDG base directory
# Reference: scripts/provisioning/create-xdg-dir.sh

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME/zsh/zsh_history"

# zinit
export ZINITDIR="$XDG_DATA_HOME/zinit"
declare -Agx ZINIT
ZINIT[HOME_DIR]="$ZINITDIR"
ZINIT[BIN_DIR]="$ZINITDIR/bin"
ZINIT[PLUGINS_DIR]="$ZINITDIR/plugins"
ZINIT[COMPLETIONS_DIR]="$ZINITDIR/completions"
ZINIT[SNIPPETS_DIR]="$ZINITDIR/snippets"
ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zcompdump/zcompdump-zinit"

# z.lua
export _ZL_DATA="$XDG_DATA_HOME/zlua/.zlua"

# asdf
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="$XDG_CONFIG_HOME/asdf/tool-versions"
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"

# node.js
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/node_repl_history"

# ToDo: python
# Reference: https://docs.python.org/3/library/readline.html?highlight=readline#example

# golang
export GOPATH="$XDG_DATA_HOME/go"

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"

# k9s
export K9SCONFIG="$XDG_CONFIG_HOME/k9s"

# aws cli & sdk
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SDK_LOAD_CONFIG="true"

# tealdeer (tldr)
export TEALDEER_CONFIG_DIR="$XDG_CONFIG_HOME/tealdeer"
export TEALDEER_CACHE_DIR="$XDG_CACHE_HOME/tealdeer"

# Disable unneeded histories
## less
export LESSHISTFILE=-
## wget
alias wget="wget --no-hsts"
