# Setup

- Create a dotfiles folder to track dotfiles

```bash
git init --bare $HOME/dotfiles
```

- Add an alias `dotfiles` to your `.zshrc`

```bash
alias dotfiles="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
```

- Set git status to hide untracked files

```bash
dotfiles config --local status.showUntrackedFiles no
```

# Usage

```bash
dotfiles status

# .zshrc
dotfiles add $HOME/.zshrc
dotfiles commit -m "feat: add .zshrc"

# ZSH_CONFIG
dotfiles add $HOME/ZSH_CONFIG/*
dotfiles commit -m "feat: add ZSH_CONFIG files"

dotfiles remote add origin git@github.com:USERNAME/dotfiles.git
dotfiles push origin master
```

Original written: [lesley-tw@github](https://github.com/lesley-tw)

Edited by: [kirintwn@github](https://github.com/kirintwn)
