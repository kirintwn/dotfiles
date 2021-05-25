# Component: dotfiles
# Purpose: alias for dotfiles add
#          intentionally to use zsh fallback file-only completion because "git add" completion is broken with git bare repository
# Reference: https://stackoverflow.com/a/33191364
#            https://unix.stackexchange.com/questions/550559/zsh-file-autocompletion-with-bare-git-repo
function da() {
  git --git-dir="$XDG_DATA_HOME/dotfiles/" --work-tree="$HOME" add $@
}
