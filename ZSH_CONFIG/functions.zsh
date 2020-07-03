# component: dotfiles
# purpose: alias for dotfiles add
#          intentionally to use zsh fallback file-only completion because "git add" completion is broken with git bare repository
# reference: https://stackoverflow.com/a/33191364
#            https://unix.stackexchange.com/questions/550559/zsh-file-autocompletion-with-bare-git-repo
function da() {
  git --git-dir=$HOME/dotfiles/ --work-tree=$HOME add $@
}

# component: diff
# purpose: use delta as diff
# reference: https://github.com/dandavison/delta/pull/56
function dt() {
  diff -u $@ | delta --theme="Dracula"
}
