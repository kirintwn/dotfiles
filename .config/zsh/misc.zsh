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
# Purpose: provide cd preview
# Reference: https://github.com/Aloxaf/fzf-tab#configure
local extract="
# trim input
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"
zstyle ":fzf-tab:*" single-group ""
zstyle ":fzf-tab:complete:cd:*" extra-opts --preview=$extract'exa -1 --color=always --icons --group-directories-first $realpath'


# Component: fzf-tab & z.lua
# Purpose: use input as query string when completing z.lua
# Reference: https://github.com/Aloxaf/fzf-tab#configure
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# Component: fzf-tab
# Purpose: disable default command keybinding (I use tab for `accept` action)
# Reference: https://github.com/Aloxaf/fzf-tab#command
FZF_TAB_COMMAND=(
  fzf
  --ansi
  --expect='$continuous_trigger' # For continuous completion
  '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
  --nth=2,3 --delimiter='\x00'  # Don't search prefix
  --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
  --tiebreak=begin -m --cycle
  '--query=$query'
  '--header-lines=$#headers'
)
zstyle ":fzf-tab:*" command $FZF_TAB_COMMAND