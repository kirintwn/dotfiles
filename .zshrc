export ZSH_CONFIG=$HOME/ZSH_CONFIG

typeset -ga sources
sources+="$ZSH_CONFIG/theme.zsh"
sources+="$ZSH_CONFIG/environment.zsh"
sources+="$ZSH_CONFIG/zinit.zsh"
sources+="$ZSH_CONFIG/aliases.zsh"
sources+="$ZSH_CONFIG/misc.zsh"
sources+="$ZSH_CONFIG/trend.zsh"

foreach file (`echo $sources`)
  if [[ -a $file ]]; then
    source $file
  fi
end
