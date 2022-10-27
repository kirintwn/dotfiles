export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export HISTSIZE=10000000
export SAVEHIST=10000000

export VISUAL=nvim
export EDITOR="$VISUAL"

export PAGER=less
export LESS=-RF

export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border --bind=tab:accept"

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

export DOCKER_BUILDKIT=1

export SSH_AUTH_SOCK=~/.1password/agent.sock

path+="$HOME/.local/bin"
path+="$GOBIN"
export PATH

if command -v fnm &> /dev/null; then
  eval "$(fnm env)"
fi
