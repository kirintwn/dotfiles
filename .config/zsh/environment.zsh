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

export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

PATH="$GOBIN:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH

if command -v fnm &> /dev/null; then
  eval "$(fnm env)"
fi
