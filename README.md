# Dotfiles

## Setup

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

## Usage

```bash
dotfiles status

# .zshrc
dotfiles add $HOME/.zshenv
dotfiles commit -m "feat: add .zshenv"

# ZSH_CONFIG
dotfiles add $HOME/.config/git/*
dotfiles commit -m "feat: add git config files"

dotfiles remote add origin git@github.com:USERNAME/dotfiles.git
dotfiles push origin master
```

## Restore dotfiles to new machine

```bash
alias dotfiles="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
git clone --bare git@github.com:USERNAME/dotfiles.git $HOME/dotfiles

# please remove all conflict files in $HOME before running dotfiles checkout
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

Original written: [lesley-tw@github](https://github.com/lesley-tw)

Edited by: [kirintwn@github](https://github.com/kirintwn)
