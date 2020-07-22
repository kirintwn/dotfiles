declare -ga sources
sources+="$ZDOTDIR/theme.zsh"
sources+="$ZDOTDIR/environment.zsh"
sources+="$ZDOTDIR/zinit.zsh"
sources+="$ZDOTDIR/aliases.zsh"
sources+="$ZDOTDIR/functions.zsh"
sources+="$ZDOTDIR/misc.zsh"
sources+="$ZDOTDIR/trend.zsh"

foreach file (`echo $sources`)
  if [[ -a $file ]]; then
    source $file
  fi
end
