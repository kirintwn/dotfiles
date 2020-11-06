# Component: ssh & slogin
# Purpose: completion with hosts in ~/.ssh/config & ~/.ssh/known_hosts
# Reference: https://stackoverflow.com/questions/54309712/zsh-doesnt-autocomplete-correctly-my-ssh-command
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  h=($h ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# Component: fzf-tab
# Purpose: provide cd, cat (bat) & vim (nvim) preview
# Reference: https://github.com/Aloxaf/fzf-tab/wiki/Preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always --icons --group-directories-first $realpath'

zstyle ':fzf-tab:complete:(bat|nvim):*' fzf-preview '
  bat --style=numbers --color=always --line-range :200 $realpath 2>/dev/null ||
  exa -1 --color=always --icons --group-directories-first $realpath
'

# Component: fzf-tab & z.lua
# Purpose: use input as query string when completing z.lua
# Reference: https://github.com/Aloxaf/fzf-tab/wiki/Configuration#zstyle
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# Component: fzf-tab
# Purpose: overwrite height & keybinding (I use tab for `accept` action)
# Reference: https://github.com/Aloxaf/fzf-tab/wiki/Configuration#fzf-flags
zstyle ':fzf-tab:*' fzf-flags --height=75% --bind=tab:accept,change:top,alt-space:toggle
