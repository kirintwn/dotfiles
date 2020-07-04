export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# mkdir -p $XDG_CONFIG_HOME/asdf
# mkdir -p $XDG_DATA_HOME/{zsh,zlua,node,asdf}

# zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE=$XDG_DATA_HOME/zsh/zsh_history

# z.lua
export _ZL_DATA=$XDG_DATA_HOME/zlua/.zlua

# asdf
export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdf/asdfrc
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=$XDG_CONFIG_HOME/asdf/tool-versions
export ASDF_DATA_DIR=$XDG_DATA_HOME/asdf

# node.js
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node/node_repl_history
