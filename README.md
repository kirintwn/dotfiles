# Dotfiles

## Setup

* Create a dotfiles folder to track dotfiles

  ```bash
  git init --bare $HOME/dotfiles
  ```

* Add an alias `dotfiles` to your `.zshrc`

  ```bash
  alias dotfiles="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
  ```

* Set git status to hide untracked files

  ```bash
  dotfiles config --local status.showUntrackedFiles no
  ```

## Usage

```bash
dotfiles status

# .zshrc
dotfiles add $HOME/.zshenv
dotfiles commit -m "feat: add .zshenv"

# git config
dotfiles add $HOME/.config/git/*
dotfiles commit -m "feat: add git config files"

dotfiles remote add origin git@github.com:USERNAME/dotfiles.git
dotfiles push origin master
```

## Restore dotfiles to new machine

* Prerequisites: `curl`, `wget`, `git`, `svn`

* Installation:

  1. Clone & checkout

    ```bash
    alias dotfiles="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"
    git clone --bare git@github.com:USERNAME/dotfiles.git $HOME/dotfiles

    # please remove all conflict files in $HOME before running dotfiles checkout
    dotfiles checkout
    dotfiles config --local status.showUntrackedFiles no
    ```

  2. Open a new zsh shell, wait `zinit` provisioning (would take a few minutes).

  3. Create some directories for some program to use XDG base directory,
    please see [`scripts/provisioning/create-xdg-dir.sh`](scripts/provisioning/create-xdg-dir.sh)
    as a reference.

  4. Install programming languages with `asdf`,
    please see [`scripts/install-packages/asdf.sh`](scripts/install-packages/asdf.sh) as a reference.

  5. Install some packages dependent on `node.js` & `python`,
    please see [`scripts/install-packages/npm.sh`](scripts/install-packages/npm.sh)
    & [`scripts/install-packages/pip.sh`](scripts/install-packages/pip.sh) as a reference.

  6. you can now run `:checkhealth provider` in neovim to see if it works correctly.

## Caveats

* Some packages will failed to write config / data if the target directory not exists.
  Please see comments in `.zshenv` to provision those directories.

* Zinit plugin `z.lua` needs `lua`, `lua` needs `asdf` & `asdf` needs `zinit`,
  so you should install `lua` via [`scripts/install-packages/asdf.sh`](scripts/install-packages/asdf.sh),
  then re-open a new shell to load `z.lua`.

* The installation of `Python` is via [`asdf-python`](https://github.com/danhper/asdf-python).
  Please see [common build problem in pyenv](https://github.com/pyenv/pyenv/wiki/Common-build-problems)
  if you encountered any problem.

* Neovim needs [`junegunn/vim-plug`](https://github.com/junegunn/vim-plug),
  please follow the [installation guide](https://github.com/junegunn/vim-plug#installation),
  and run `:PlugInstall` in neovim.

* Some neovim's plugins needs node.js / python's neovim packages.
  Please install those packages via scripts in [`scripts/install-packages/pip.sh`](scripts/install-packages/pip.sh)
  & [`scripts/install-packages/npm.sh`](scripts/install-packages/npm.sh).

## References

* [[ArchLinux Wiki] XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory)

* [[Atlassian] The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)

* [Zinit offical Wiki](https://zdharma.org/zinit/wiki/)

#### Original written: [@lesley-tw](https://github.com/lesley-tw)

#### Edited by: [@kirintwn](https://github.com/kirintwn)
